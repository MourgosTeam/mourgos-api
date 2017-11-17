var express = require('express');
var router = new express.Router();
var knex = require('../db/db.js');
var base32 = require('base32');

/* GET users listing. */
router.get('/', (req, res) => {
  knex.table('orders').select('*').
  then((data) => {
    var result = {};
    for (var ic = 0; ic < data.length; ic += 1) {
      result[data[ic].Name] = data[ic].Value;
    }
    res.send(result);
  });
});

router.get('/:id', (req, res) => {
  knex.table('orders').select('*').
where({ id: req.params.id }).
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
    Total: ni.basketTotal
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
function calculateMoney(product, attrs, item) {
var nattrs = normalizeAttributes(attrs);
var money = parseFloat(product.Price);

for (var id in item.attributes) {
if (!nattrs[id]) {
 throw Error('Attribute not in the list');
}
var opt = parseInt(item.attributes[id], 10);
if (nattrs[id].Options.length <= opt || opt < -1) {
 throw Error('Attribute not in the list2');
} else {
 money += parseFloat(nattrs[id].Price);
}
}

return parseFloat(money) * parseInt(item.quantity, 10);
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
