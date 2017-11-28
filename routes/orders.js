var express = require('express');
var router = new express.Router();
var knex = require('../db/db.js');

var auth = require('../helpers/auth');

var Functions = require('./orderFunctions');
var Layer = require('./ordersLayer');
var io = require('../sockets/mobile')();


/* GET ORDERS listing. */
router.get('/', (req, res) => {

res.sendStatus(404);

return false;

/*
 *  knex.table('orders').select('*').
 * orderBy('postDate', 'desc').
 * then((data) => {
 *   res.send(data);
 * });
 */
});

router.get('/saw/:id', (req, res) => {
 if (!auth.checkUser(req, res) || req.params.id.length !== 5) {
  return false;
 }

return Layer.orderOpened(req.params.id).
 then(() => Layer.notifyOrder(req.params.id)).
 then(() => res.send({ msg: 'OK' }));
});


router.get('/my', (req, res) => {
  if (!auth.checkUser(req, res)) {
    return false;
  }
  Layer.sendShopOrders(req, res);

return true;
});

router.get('/:id', (req, res) => {
  knex.table('orders').select('*').
where({ id: req.params.id }).
map(Functions.calculateDescription).
then((data) => res.send(data[0]));
});

router.post('/:id', (req, res) => {
    if (!auth.checkUser(req, res)) {
        return false;
    }
 const status = parseInt(req.body.statusCode, 10);

 return Layer.updateOrderStatus(req, res, req.params.id, status).
 then((order) => {
  order.Status = status;
  res.send(order);

  return order;
 }).
 then((order) => Layer.notifyOrder(order.id)).
 catch(() => {
  res.sendStatus(500);

  return true;
 });
});

router.post('/', (req, res) => {
  var order = Layer.castToOrder(req.body);
  Functions.verify(order).
  then(() => Layer.insertOrder(order)).
  then(() => {
    io.sendToCatalogue(order.catalogue_id, 'new-order');
    res.status(200);
    res.send(order);
  }).
  catch((err) => {
    res.status(500);
    res.send(err);
  });
});


module.exports = router;
