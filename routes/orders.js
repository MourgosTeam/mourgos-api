var express = require('express');
var router = new express.Router();
var knex = require('../db/db.js');
var base32 = require('base32');
var Constants = require('../constants/constants');

var Functions = require('./orderFunctions');
var io = require('../sockets/mobile')();

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
  orderBy('postDate', 'desc').
  then((data) => {
    res.send(data);
  });
});

router.get('/my', (req, res) => {
  if (!checkUser(req, res)) {
 return false;
}
  knex.table('orders').select(Constants.MYORDERFILEDS).
orderBy('postDate', 'desc').
join('catalogues', 'orders.catalogue_id', '=', 'catalogues.id').
where({ user_id: req.sessionUser.id }).
map(Functions.calculateDescription).
then((data) => res.send(data));

return true;
});

router.get('/:id', (req, res) => {
  knex.table('orders').select('*').
where({ id: req.params.id }).
map(Functions.calculateDescription).
then((data) => res.send(data[0]));
});

router.post('/:id', (req, res) => {
    if (!checkUser(req, res)) {
 return false;
}
let order = {};

return knex.table('orders').select('*').
where({ id: req.params.id }).
then((orders) => {
 [order] = orders;

return Functions.isMyCatalogue(orders[0].catid, req);
}).
then(() => knex.table('orders').where({ id: req.params.id }).
update({ Status: parseInt(req.body.statusCode, 10) })).
then(() => {
 order.Status = parseInt(req.body.statusCode, 10);
 res.send(order);
}).
catch(() => {
    res.sendStatus(500);

return true;
});
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
  Functions.verify(order).
  then(() => {
    // verified
    var pos = parseInt(Math.random() * 5, 10) + 2;
    var hash = base32.encode((Math.random() * 10000000).toString());
    order.id = hash.toString().substr(pos, 5);
    order.Items = JSON.stringify(order.Items);

return knex.table('orders').insert(order);
  }).
  then(() => {
    io.sendToCatalogue(ni.catalogue, 'new-order');
    res.status(200);
    res.send(order);
  }).
  catch((err) => {
    res.status(500);
    res.send(err);
  });

/*
 *   knex.table('orders').insert(order).
 * then((data) => res.send(data));
 */
});


module.exports = router;
