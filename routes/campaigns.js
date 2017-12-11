var express = require('express');
var router = new express.Router();

var HashtagLayer = require('./hashtagLayer');

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
  // knex.table('catalogues').insert(req.body).then((data) => res.send(data));
});

module.exports = router;
