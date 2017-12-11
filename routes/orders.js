var express = require('express');
var router = new express.Router();
var knex = require('../db/db.js');

var auth = require('../helpers/auth');

var Functions = require('./orderFunctions');
var Layer = require('./ordersLayer');
var io = require('../sockets/mobile')();


var Constants = require('../constants/constants');

var Logger = require('../helpers/logger');

/* GET ORDERS listing. */
router.get('/', (req, res) => {

  if (!auth.isAdmin(req)) {
    return res.sendStatus(403);
  }

  return Layer.sendAllOrders().
  then((data) => {
    res.send(data);
  });
});

router.get('/logs', (req, res) => {
  if (!auth.isAdmin(req)) {
    return res.sendStatus(403);
  }

  return Layer.sendOrderLogs().
  then((data) => {
    res.send(data);
  });
});

router.post('/saw/:id', (req, res) => {
 if (!auth.checkUser(req, res) || req.params.id.length !== 5) {
  return false;
 }

  if (auth.isDelivery(req)) {

    return Logger.logIfNotExists(req, 'Orders', 'Seen', req.params.id).
    then(() => res.send({ msg: 'OK' }));
  }

return Layer.orderOpened(req, req.params.id).
 then(() =>
  Logger.logIfNotExists(req, 'Orders', 'Seen - Getting ready', req.params.id)).
 then(() => Layer.notifyOrder(req.params.id)).
 then(() => res.send({ msg: 'OK' })).
 then(() => Logger.log(req, 'Orders', 'Seen', req.params.id));
});


router.get('/my', (req, res) => {
  if (!auth.checkUser(req, res)) {
    return false;
  }
  if (auth.isShop(req)) {
    Layer.sendShopOrders(req, res);
  } else if (auth.isDelivery(req)) {
    Layer.sendDeliveryOrders(req, res);
  } else {
    res.sendStatus(403);
  }

return true;
});

router.get('/free', (req, res) => {
  if (!auth.checkUser(req, res)) {
    return false;
  }
  if (auth.isDelivery(req)) {
    Layer.sendFreeOrders(req, res);
  } else {
    res.sendStatus(403);
  }

return true;
});

router.get('/assign/:id', (req, res) => {
  if (!auth.checkUser(req, res) || req.params.id.length !== 5) {
    return false;
  }
  if (auth.isDelivery(req)) {
    Layer.assignMeOrder(req, res, req.params.id).
    then(() => Logger.log(req, 'Orders', 'Assigned', req.params.id));
  }

  return true;
});

router.get('/free/:id', (req, res) => {
  if (!auth.checkUser(req, res) || req.params.id.length !== 5) {
    return false;
  }
  if (auth.isDelivery(req)) {
    Layer.freeOrder(req, res, req.params.id).
    then(() => Logger.log(req, 'Orders', 'Freed', req.params.id));
  }

  return true;
});
router.get('/delivered/:id', (req, res) => {
  if (!auth.checkUser(req, res) || req.params.id.length !== 5) {
    return false;
  }
  if (auth.isDelivery(req)) {
    Layer.orderDelivered(req, res, req.params.id).
    then(() => Layer.notifyOrder(req.params.id)).
    then(() => res.send({ msg: 'OK' })).
    then(() => Logger.log(req, 'Orders', 'Delivered', req.params.id));
  }

  return true;
});

router.get('/:id', (req, res) => {
  knex.table('orders').select('*').//Constants.ORDERFIELDS).
  //join('campaigns', 'campaigns.Hashtag', '=', 'orders.Hashtag').
  where({ 'orders.id': req.params.id }).
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