var express = require('express');
var router = new express.Router();
var knex = require('../db/db.js');
var base32 = require('base32');

function checkUser(req, res) {
  if (!req.sessionUser) {
    res.status(403);
    res.send('You shall not pass');

return false;
  }

return true;
}


/* GET ORDERS listing. */
router.get('/', (req, res) => {
  knex.table('orders').select('*').
  then((data) => {
    res.send(data);
  });
});

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
const PRODUCTSMAINFIELDS = [
'Price',
'Name',
'Description',
'id'
];
function getProductAndAttributes(item) {
let prod = {};

return knex.table('products').select(PRODUCTSMAINFIELDS).
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

const MYORDERFILEDS = [
  'orders.id as id',
  'orders.Name as Name',
  'orders.Status as Status',
  'orders.Address as Address',
  'orders.Orofos as Orofos',
  'orders.Phone as Phone',
  'orders.Koudouni as Koudouni',
  'orders.Comments as Comments',
  'orders.Items as Items',
  'orders.Extra as Extra',
  'orders.Total as Total',
  'orders.catalogue_id as CatalogueId'

  /*
   * I can include some fields
   * from catalogues table
   */
];
router.get('/my', (req, res) => {
  if (!checkUser(req, res)) {
 return false;
}
  knex.table('orders').select(MYORDERFILEDS).
join('catalogues', 'orders.catalogue_id', '=', 'catalogues.id').
where({ user_id: req.sessionUser.id }).
map(calculateDescription).
then((data) => res.send(data));

return true;
});

router.get('/:id', (req, res) => {
  knex.table('orders').select('*').
where({ id: req.params.id }).
map(calculateDescription).
then((data) => res.send(data[0]));
});

router.post('/', (req, res) => {
  var ni = req.body;
  var order = {
    Address: ni.address,
    Comments: ni.comments,
    Extra: ni.hasExtra,
    Items: ni.basketItems,
    Koudouni: ni.koudouni,
    Name: ni.name,
    Orofos: ni.orofos,
    Phone: ni.phone,
    Total: ni.basketTotal,
    catalogue_id: ni.catalogue
  };
  verify(order).
  then(() => {
    // verified
    var pos = parseInt(Math.random() * 5, 10) + 2;
    var hash = base32.encode((Math.random() * 10000000).toString());
    order.id = hash.toString().substr(pos, 5);
    order.Items = JSON.stringify(order.Items);

return knex.table('orders').
    insert(order).
    then(() => {
      res.status(200);
      res.send(order);
    });
  }).
catch((err) => {
    console.log(err);
    res.status(400);
    res.send('This order shall not pass!');
  });

/*
 *   knex.table('orders').insert(order).
 * then((data) => res.send(data));
 */
});


function normalizeAttributes(attrs) {
  var nattrs = {};
  for (var ic = 0; ic < attrs.length; ic += 1) {
   nattrs[attrs[ic].id] = attrs[ic];
  }

return nattrs;
}
function getAttributePrice(nattr, attribute) {
if (!nattr) {
 throw Error('Attribute not in the list');
}
var money = 0;
var opt = parseInt(attribute, 10);
if (nattr.Options.length <= opt || opt < -1) {
 throw Error('Attribute not in the list2');
} else {
 money += parseFloat(nattr.Price);
}

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
 throw Error({ 'msg': 'Item is not in my view' });
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
 throw Error({ 'msg': 'The total is wrong' });
}

return money;
      });
}
function verify(order) {
  if (!order.Name || !order.Address ||
      !order.Orofos || !order.Phone ||
      !order.Items || !order.Total) {
return false;
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
 throw Error({ 'msg': 'The total is different than the one calculated' });
}
// extra charge

return knex.table('globals').select('*').
    where({ Name: 'MinimumOrder' }).
    then((data) => {
      var minimumOrder = data[0].Value;
      if (parseFloat(money) < parseFloat(minimumOrder) && !order.Extra) {
throw Error({ 'msg': 'The order is under the minimumOrder' });
}

return money;
    });
  });

return prom;
}

module.exports = router;
