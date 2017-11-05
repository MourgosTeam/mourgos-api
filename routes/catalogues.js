var express = require('express');
var router = new express.Router();

var knex = require('../db/db.js');

/* GET users listing. */
router.get('/', (req, res) => {
  knex.table('catalogues').select('*').
then((data) => res.send(data));
});
router.get('/:id', (req, res) => {
  knex.table('catalogues').select('*').
where({ id: req.params.id }).
then((data) => res.send(data[0]));
});

router.post('/', (req, res) => {
  knex.table('catalogues').insert(req.body).
then((data) => res.send(data));
});

module.exports = router;
