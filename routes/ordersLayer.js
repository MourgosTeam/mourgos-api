var knex = require('../db/db.js');
var base32 = require('base32');
var Constants = require('../constants/constants');
var Functions = require('./orderFunctions');

var io = require('../sockets/mobile')();


function castToOrder (ni) {
 return {
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
function orderOpened (id) {
  return knex.table('orders').where({ id }).
 update({ hasOpened: 1 });
}

function sendShopOrders (req, res) {
 knex.table('orders').select(Constants.MYORDERFILEDS).
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
 castToOrder,
 insertOrder,
 notifyOrder,
 orderOpened,
 sendShopOrders,
 updateOrderStatus
};