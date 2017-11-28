var knex = require('../db/db.js');
var Constants = require('../constants/constants');
var Functions = require('./orderFunctions');


function sendShopOrders (req, res) {
 knex.table('orders').select(Constants.MYORDERFILEDS).
 orderBy('postDate', 'desc').
 join('catalogues', 'orders.catalogue_id', '=', 'catalogues.id').
 where({ user_id: req.sessionUser.id }).
 map(Functions.calculateDescription).
 then((data) => res.send(data));
}

module.exports = { sendShopOrders };