var express = require('express');
var router = new express.Router();

var knex = require('../db/db.js');

/* GET users listing. */
router.get('/', (req, res) => {
  knex.table('attributes').select('*').
then((data) => res.send(data));
});

router.get('/product/:productid', (req, res) => {
  knex.table('attributes').select('*').
where({ product_id: req.params.productid }).
then((data) => res.send(data));
});

router.get('/:id', (req, res) => {
  knex.table('attributes').select('*').
where({ id: req.params.id }).
then((data) => res.send(data[0]));
});

router.post('/', (req, res) => {
  knex.table('attributes').insert(req.body).
then((data) => res.send(data));
});

module.exports = router;
