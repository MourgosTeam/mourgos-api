var express = require('express');
var router = new express.Router();

var HashtagLayer = require('./hashtagLayer');
var auth = require('../helpers/auth');
var knex = require('../db/db.js');

/* GET users listing. */
router.get('/', (req, res) => {
  knex.table('campaigns').select('*').
  then((data) => res.send(data));
});

router.get('/id/:id', (req, res) => {
  knex.table('campaigns').select('*').
  where({ id: req.params.id }).
  then((data) => res.send(data[0]));
});

router.get('/:hash', (req, res) => {
  console.log('Hashtag ' + req.params.hash);

return HashtagLayer.checkHashtag(req.params.hash).
  then((item) => res.send(item)).
  catch((err) => {
    console.log(err);
    res.status(409);
    res.send(err);
  });
});

router.post('/', (req, res) => {
  res.sendStatus(500);

  return false;
  // knex.table('campaigns').insert(req.body).then((data) => res.send(data));
});


router.post('/new', (req, res) => {
  if (!auth.isAdmin(req)) {
    return res.sendStatus(403);
  }

  const item = {
    CurrentUsages: 0,
    Formula: req.body.formula,
    Hashtag: req.body.hashtag,
    MaxUsages: req.body.usages,
    Name: req.body.name
  };

  return knex.table('campaigns').insert(item).
       then((data) => res.send(data));
});

router.post('/edit/:id', (req, res) => {
  if (!auth.isAdmin(req)) {
    return res.sendStatus(403);
  }

  const EDITFIELDS = {
    Formula: 1,
    MaxUsages: 1
  };

  const upobj = req.body;
  for (var key in upobj) {
    if (isNaN(upobj[key]) || EDITFIELDS[key] !== 1) {
      return res.sendStatus(400);
    }
  }

  return knex.table('campaigns').
              where({ id: req.params.id }).
              update(upobj).
       then(() => res.send({ msg: 'OK' }));
});


module.exports = router;
