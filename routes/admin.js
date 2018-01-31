var express = require('express');
var router = new express.Router();

var auth = require('../helpers/auth');
var knex = require('../db/db.js');

var importLayer = require('../helpers/importLayer');

/* GET OPEN SITE REQUEST. */
router.get('/site/open', (req, res) => {
  if (!auth.isAdmin(req)) {

    return res.sendStatus(403);
  }

  return knex.table('globals').where({ Name: 'MourgosIsLive' }).
  update({ Value: 1 }).
  then(() => res.send(true)).
  catch((err) => res.send(err));
});

router.post('/site/problem', (req, res) => {
  if (!auth.isAdmin(req)) {

    return res.sendStatus(403);
  }

  return knex.table('globals').where({ Name: 'MourgosHasProblem' }).
  update({ Value: req.body.value }).
  then(() => res.send(true)).
  catch((err) => res.send(err));

});

/* GET CLOSE SITE REQUEST. */
router.get('/site/close', (req, res) => {
  if (!auth.isAdmin(req)) {

    return res.sendStatus(403);
  }

  return knex.table('globals').where({ Name: 'MourgosIsLive' }).
  update({ Value: 0 }).
  then(() => res.send(false)).
  catch((err) => res.send(err));
});

/* GET Couriers REQUEST. */
router.get('/couriers', (req, res) => {
  if (!auth.isAdmin(req)) {

    return res.sendStatus(403);
  }

  return knex.table('users').where({ role: 2 }).
  select('*').
  then((data) => res.send(data)).
  catch((err) => res.send(err));
});


router.post('/import', (req, res) => {
  if (!auth.isAdmin(req)) {
    return res.sendStatus(403);
  }

  const attributes = req.body.Attributes,
    categories = req.body.Categories,
    connectors = req.body.Connectors,
    products = req.body.Products;

  const successmsg = {};

  return importLayer.insertOrUpdate('categories', categories).
  then((inserted) => {
    successmsg.Categories = inserted;

    return importLayer.insertOrUpdate('attributes', attributes);
  }).
  then((inserted) => {
    successmsg.Attributes = inserted;

    return importLayer.insertOrUpdate('products', products);
  }).
  then((inserted) => {
    successmsg.Products = inserted;

    return importLayer.insertOrUpdate('productattributes', connectors);
  }).
  then((inserted) => {
    successmsg.Connectors = inserted;

    return res.send(successmsg);
  }).
  catch((err) => {
    res.status(400);
    res.send(err);
    throw err;
  });
});

module.exports = router;