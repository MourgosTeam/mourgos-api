var express = require('express');
var router = new express.Router();
var knex = require('../db/db.js');

var auth = require('../helpers/auth');

var Functions = require('./orderFunctions');
var Layer = require('./ordersLayer');
var io = require('../sockets/mobile')();

var HashtagLayer = require('./hashtagLayer');

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
 then(() => Logger.logIfNotExists(req, 'Orders', 'Seen', req.params.id));
});


router.get('/my', (req, res) => {
  if (!auth.checkUser(req, res)) {
    return false;
  }

  console.log(req.sessionUser);
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
    then(() => Logger.logIfNotExists(req, 'Orders', 'Assigned', req.params.id));
  }

  return true;
});

router.get('/free/:id', (req, res) => {
  if (!auth.checkUser(req, res) || req.params.id.length !== 5) {
    return false;
  }
  if (auth.isDelivery(req)) {
    Layer.freeOrder(req, res, req.params.id).
    then(() => Logger.logIfNotExists(req, 'Orders', 'Freed', req.params.id));
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
    then(() =>
      Logger.logIfNotExists(req, 'Orders', 'Delivered', req.params.id));
  }

  return true;
});

router.get('/:id', (req, res) => {

  // Constants.ORDERFIELDS).
  knex.table('orders').select(Constants.ORDERFIELDS).
  join('catalogues', 'orders.catalogue_id', '=', 'catalogues.id').
  leftJoin('campaigns', 'campaigns.Hashtag', '=', 'orders.Hashtag').
  where({ 'orders.id': req.params.id }).
  map(Functions.calculateDescription).
  then(Functions.addFinalPrice).
  then((data) => res.send(data[0] || {}));
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
 }).
 then(() =>
  Logger.logIfNotExists(
            req,
            'Orders',
            'StatusChange : ' + Constants.statusTexts[req.body.statusCode],
            req.params.id
            ));
});

router.post('/', (req, res) => {
  const order = Layer.castToOrder(req.body);

  return auth.isSiteOpen().
  then((flag) => {
    if (flag === false) {
      const err = new Error('Site is closed!');
      err.errorObject = {
       code: 8888,
       msg: 'Site is closed!'
      };
      throw err;
    }

    return flag;
  }).
  then(() => Functions.verify(order)).
  then(() => HashtagLayer.updateHashtag(order.Hashtag)).
  then(() => Layer.insertOrder(order)).
  then(() => {
    io.sendToCatalogue(order.catalogue_id, 'new-order');
    res.status(200);
    res.send(order);
  }).
  catch((err) => {
    console.log(err);
    if (err.errorObject && err.errorObject.code === 8888) {
      res.status(503);
    } else {
      res.status(500);
    }
    res.send(err.errorObject);
  });
});

module.exports = router;