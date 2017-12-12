var knex = require('../db/db.js');

function checkUser(req, res) {
  if (!req.sessionUser) {
    res.status(403);
    res.send('You shall not pass');

return false;
  }

return true;
}

function getUserID(req) {
    if (!req.sessionUser) {
     return false;
    }

    return req.sessionUser.id;
}

function hasRole(req, role) {
 if (!req.sessionUser || req.sessionUser.role !== role) {

  return false;
 }

 return true;
}

function isAdmin(req) {
 return hasRole(req, 0);
}

function isDelivery(req) {
 return hasRole(req, 2);
}

function isShop(req) {
 return hasRole(req, 1);
}

function isSiteOpen() {
 return knex.table('globals').select('Value').where({ Name: 'MourgosIsLive' }).
 then((data) => data[0].Value === '1');
}

module.exports = {
 checkUser,
 getUserID,
 isAdmin,
 isDelivery,
 isShop,
 isSiteOpen
};