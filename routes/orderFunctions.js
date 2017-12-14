var knex = require('../db/db.js');
var Constants = require('../constants/constants');


function addFinalPrice(data) {
  return data.map((item) => {
    const extra = item.Extra * Constants.extraCharge;
    item.FinalPrice = Math.max(item.Total + extra -
                              (item.HashtagFormula || 0), 0);

    return item;
  });
}
function isMyCatalogue(catid, req) {
  return knex.table('catalogues').select('id').
where({ user_id: req.sessionUser.id }).
  then((catalogues) => {

    if (catalogues.length) {
 return catalogues[0].id;
}

return Error('not your stuff');
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
 money += parseFloat(nattr.Price);


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

function verifyItem(item) {
  if (!item) {
 return Promise.reject(Error({ 'msg': 'Item is not in my view' }));
}
  // check attributes

return knex.table('products').select('*').
      where({ id: item.id }).
      then((data) => {
        const [product] = data;

return knex.table('attributes').select('*').
where({ product_id: product.id }).
            then((attrs) => calculateMoney(product, attrs, item));
      }).
      then((money) => {
if (parseFloat(money).toFixed(2) !== parseFloat(item.TotalPrice).toFixed(2)) {
  return Promise.reject(Error({ 'msg': 'The total is wrong' }));
}

return money;
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
let prom = Promise.all(proms).
then((moneyarr) => {
 let sum = 0;
 for (var ic = 0; ic < moneyarr.length; ic += 1) {
  sum += moneyarr[ic];
 }

return sum;
});
prom = prom.then((money) => {

    /*
     * I have total money and all verified
     * make finale verifications
     */
    if (parseFloat(money).toFixed(2) !== parseFloat(order.Total).toFixed(2)) {
 return Promise.reject(Error({ 'msg': 'total different than calculated' }));
}
// extra charge

return knex.table('globals').select('*').
    where({ Name: 'MinimumOrder' }).
    then((data) => {
      var minimumOrder = data[0].Value;
      if (parseFloat(money) < parseFloat(minimumOrder) && !order.Extra) {
 return Promise.reject(Error({ 'msg': 'The order is under the minimumOrder' }));
}

return money;
    });
  });

return prom;
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

return knex.table('attributes').select('*').
where({ product_id: prod.id });
      }).
then((attrs) => ({
          attributes: attrs,
          product: prod
        }));
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