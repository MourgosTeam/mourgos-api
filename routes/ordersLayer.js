var knex = require('../db/db.js');
var base32 = require('base32');
var Constants = require('../constants/constants');
var Functions = require('./orderFunctions');

var io = require('../sockets/mobile')();


function assignMeOrder(req, res, orderId) {
 return knex.table('orders').
 where({
   delivery_id: null,
   id: orderId
 }).
 update({ delivery_id: req.sessionUser.id }).
 then((updated) => {
  const updates = updated;
  if (updates !== 1) {
    res.sendStatus(409);

    return;
  }
  io.sendToCatalogue('all', 'assign-order');
  res.send({ msg: 'ok' });
 }).
 catch((err) => {
  console.log(err);
  res.sendStatus(500);
 });
}

function castToOrder (ni) {
 return {
    Address: ni.address,
    Comments: ni.comments,
    Extra: ni.hasExtra,
    Hashtag: ni.coupon,
    Items: ni.basketItems,
    Koudouni: ni.koudouni,
    Latitude: ni.latitude,
    Longitude: ni.longitude,
    Name: ni.name,
    Orofos: ni.orofos,
    Phone: ni.phone,
    Total: ni.basketTotal,
    catalogue_id: ni.catalogue
  };
}


function freeOrder(req, res, orderId) {
 return knex.table('orders').
 where({
   delivery_id: req.sessionUser.id,
   id: orderId
 }).
 update({ delivery_id: null }).
 then((updated) => {
  const updates = updated;
  if (updates !== 1) {
    res.sendStatus(409);

    return;
  }
  io.sendToCatalogue('all', 'assign-order');
  res.send({ msg: 'ok' });
 }).
 catch((err) => {
  console.log(err);
  res.sendStatus(500);
 });
}

function orderDelivered(req, res, orderId) {
 return knex.table('orders').
 where({
   delivery_id: req.sessionUser.id,
   id: orderId
 }).
 update({ Status: 10 }).
 then((updated) => {
  const updates = updated;
  if (updates !== 1) {
    res.sendStatus(409);
    const err = { status: 409 };

    throw err;
  }
 });
}

function orderOpened (req, id) {
 return knex.table('orders').
 where({
   catalogue_id: req.sessionUser.id,
   id
 }).
 update({ Status: 1 });
}

function insertOrder (order) {
    var pos = parseInt(Math.random() * 5, 10) + 2;
    var hash = base32.encode((Math.random() * 10000000).toString());
    order.id = hash.toString().substr(pos, 5);
    order.Items = JSON.stringify(order.Items);

    return knex.table('orders').insert(order);
}

function notifyOrder (id) {

  return knex.table('orders').
      select('catalogue_id').
      where({ id }).
      then((data) => io.sendToCatalogue(data[0].catalogue_id, 'update-order'));
}

function sendAllOrders() {
  return knex.table('orders').
  select(Constants.MYORDERDELIVERYFIELDS).
  join('catalogues', 'orders.catalogue_id', '=', 'catalogues.id').
  orderBy('postDate', 'desc').
  limit(200).
  map(Functions.calculateDescription);
}

function sendDeliveryOrders (req, res) {
 return knex.table('orders').select(Constants.MYORDERDELIVERYFIELDS).
 orderBy('postDate', 'desc').
 join('catalogues', 'orders.catalogue_id', '=', 'catalogues.id').
 where({ delivery_id: req.sessionUser.id }).
 limit(100).
 map(Functions.calculateDescription).
 then((data) => res.send(data));
}

function sendFreeOrders (req, res) {
 return knex.table('orders').select(Constants.MYORDERDELIVERYFIELDS).
 orderBy('postDate', 'desc').
 join('catalogues', 'orders.catalogue_id', '=', 'catalogues.id').
 where({ delivery_id: null }).
 limit(100).
 map(Functions.calculateDescription).
 then((data) => res.send(data));
}

function sendOrderLogs() {
  return knex.table('userlogs').
  join('users', 'userlogs.user_id', '=', 'users.id').
  where({ Type: 'Orders' }).
  orderBy('created_on', 'desc').
  limit(200).
  select('*');
}

function sendShopOrders (req, res) {
 return knex.table('orders').select(Constants.MYORDERFIELDS).
 orderBy('postDate', 'desc').
 join('catalogues', 'orders.catalogue_id', '=', 'catalogues.id').
 where({ user_id: req.sessionUser.id }).
 map(Functions.calculateDescription).
 then((data) => res.send(data));
}


function updateOrderStatus (req, res, ...data) {
 const [
  id,
  statusCode
  ] = data;
 let order = {};

 return knex.table('orders').select('*').
         where({ id: req.params.id }).
         then((orders) => {
            [order] = orders;

/*
 *if (parseInt(req.body.statusCode, 10) < order.Status) {
 *  throw new Error({ msg: 'No backtracing status' });
 *}
 */

            return Functions.isMyCatalogue(orders[0].catalogue_id, req);
        }).
        then(() => knex.table('orders').
                      where({ id }).
                      update({ Status: statusCode })).
        then(() => order);
}

module.exports = {
 assignMeOrder,
 castToOrder,
 freeOrder,
 insertOrder,
 notifyOrder,
 orderDelivered,
 orderOpened,
 sendAllOrders,
 sendDeliveryOrders,
 sendFreeOrders,
 sendOrderLogs,
 sendShopOrders,
 updateOrderStatus
};