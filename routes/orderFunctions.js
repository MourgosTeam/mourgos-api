var knex = require('../db/db.js');
var Constants = require('../constants/constants');


function addFinalPrice(data) {
  return data.map((order) => {
    const extra = order.Extra * Constants.extraCharge;
    const hasHash = order.Hashtag !== null && order.Hashtag.length > 3;
    const finalNoTag = parseFloat(order.Total) + extra;
    const formula = parseFloat(order.HashtagFormula);
    let calculated = 0;
    if (parseInt(formula, 10) === 100) {
      calculated = finalNoTag -
                  (hasHash === true
                  ? (formula - 100) * finalNoTag
                  : 0);
    } else {
      calculated = finalNoTag -
                  (hasHash === true
                  ? formula
                  : 0);
    }

    order.FinalPrice = Math.max(calculated, 0);

    return order;
  });
}
function isMyCatalogue(catid, req) {

  if (req.sessionUser.role === 0) {
    return Promise.resolve(true);
  }

  return knex.table('catalogues').select('id').
              where({ user_id: req.sessionUser.id }).
              then((catalogues) => {
                  if (catalogues.length) {
                    return catalogues[0].id === catid
                    ? true
                    : Promise.reject(Error('not your stuff'));
                  }

                return Promise.reject(Error('not your stuff'));
              });
}
function normalizeAttributes(attrs) {
  var nattrs = {};
  for (var ic = 0; ic < attrs.length; ic += 1) {
   nattrs[attrs[ic].id] = attrs[ic];
  }

  return nattrs;
}

function getAttributePrice(nattr, attribute) {
if (!nattr) {
  return Promise.reject(Error('Attribute not in the list'));
}
var money = 0;
var opt = parseInt(attribute, 10);
if (nattr.Options.length <= opt || opt < -1) {
  return Promise.reject(Error('Attribute not in the list2'));
}

const aprice = isNaN(nattr.Price)
            ? JSON.parse(nattr.Price)[opt]
            : parseFloat(nattr.Price);

money += aprice;

return money;
}
function calculateMoney(product, attrs, item) {
var nattrs = normalizeAttributes(attrs);
var money = parseFloat(product.Price);

for (var id in item.attributes) {
 if (!isNaN(id)) {
  money += getAttributePrice(nattrs[id], item.attributes[id]);
 }
}
money = parseFloat(money) * parseInt(item.quantity, 10);

return money;
}

function getAttributes(product) {
  return knex.table('productattributes').select('*').
        where({ ProductID: product.id }).
        then((data) => knex.table('attributes').select('*').
                        whereIn('id', data.map((item) => item.AttributeID)));
}

function verifyItem(item) {
  if (!item) {
   return Promise.reject(Error({ 'msg': 'Item is not in my view' }));
  }
  // check attributes

  return knex.table('products').select('*').
      where({ id: item.id }).
      then((data) => {
        const [product] = data;

        return getAttributes(product).
        then((attrs) => calculateMoney(product, attrs, item)).
        then((money) => {
  if (parseFloat(money).toFixed(2) !== parseFloat(item.TotalPrice).toFixed(2)) {
    const err = Error({ 'msg': 'The total is wrong' });

    return Promise.reject(err);
  }

          return money;
        });
      });
}

function isShopAvailable(order) {
  return knex.table('catalogues').select('*').
      where('id', order.catalogue_id).
  then((data) => data[0]).
  then((catalogue) => {
    const whours = catalogue.WorkingHours;
    if (whours === null) {
      return true;
    }

    const hours = whours.split(',');
    const today = new Date();
    const rightnow = today.getHours() + ':' +
          (today.getMinutes() < 10
          ? '0'
          : '') + today.getMinutes();

    if (rightnow < hours[0] || rightnow > hours[1]) {
      console.log(rightnow);
      console.log(hours);
      throw Error('Shop not available');
    }

    return true;
  });
}
function verify(order) {
  if (!order.Name || !order.Address ||
      !order.Orofos || !order.Phone ||
      !order.Items || !order.Total) {
    return Promise.reject(Error('No required values'));
  }

  var proms = [];
  for (let ic = 0; ic < order.Items.length; ic += 1) {
    proms.push(verifyItem(order.Items[ic]));
  }
  const prom = isShopAvailable(order).
  then(() => Promise.all(proms)).
  then((moneyarr) => {
    let sum = 0;
    for (var ic = 0; ic < moneyarr.length; ic += 1) {
      sum += moneyarr[ic];
    }

    return sum;
  }).
  then((money) => {
    if (parseFloat(money).toFixed(2) !== parseFloat(order.Total).toFixed(2)) {
      return Promise.
            reject(Error({ 'msg': 'total different than calculated' }));
    }

    return money;
  }).
  then((money) => applyCatalogueFilters(order, money));

  return prom;
}

function applyCatalogueFilters(order, money) {
  knex.table('catalogues').select('*').
    where({ id: order.catalogue_id }).
    then((data) => data[0].Ruleset).
    then((ruleset) => {
      switch (ruleset) {
        case 0:
          return true;
        case 1:
        default:
          return knex.table('globals').select('*').
          where({ Name: 'MinimumOrder' }).
          then((data) => {
            var minimumOrder = data[0].Value;
            if (parseFloat(money) < parseFloat(minimumOrder) && !order.Extra) {
              return Promise.
              reject(Error({ 'msg': 'The order is under the minimumOrder' }));
            }

            return money;
          });
      }
    });
}

function formDescription(theproduct, attrs, item) {
  var nattrs = normalizeAttributes(attrs);
  var result = {
    Attributes: [],
    Comments: item.comments,
    Name: theproduct.Name,
    Quantity: item.quantity
  };
  for (var id in item.attributes) {
    if (!isNaN(id)) {
      var opts = JSON.parse(nattrs[id].Options);
      result.Attributes.push({
        Name: nattrs[id].Name,
        Price: nattrs[id].Price,
        Value: opts[item.attributes[id]]
      });
    }
  }

return result;
}
function getProductAndAttributes(item) {
let prod = {};

return knex.table('products').select(Constants.PRODUCTSMAINFIELDS).
      where({ id: item.id }).
      then((products) => {
        [prod] = products;

        return getAttributes(prod).
        then((attrs) => ({
          attributes: attrs,
          product: prod
          }));
      });
}

function calculateDescription(order) {
  const items = JSON.parse(order.Items);
  let ic = 0,
len = 0;
  const proms = [];
  for (ic = 0, len = items.length; ic < len; ic += 1) {
    const item = items[ic];
    proms.push(getProductAndAttributes(item).
    then((bundle) => formDescription(bundle.product, bundle.attributes, item)));
  }

return Promise.all(proms).
  then((descriptions) => {
    order.FullDescription = descriptions;

return order;
  });
}

module.exports = {
  addFinalPrice,
  calculateDescription,
  calculateMoney,
  getAttributePrice,
  isMyCatalogue,
  normalizeAttributes,
  verify,
  verifyItem
};