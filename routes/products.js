var express = require('express');
var router = express.Router();

var knex = require('../db/db.js');

/* GET users listing. */
router.get('/', function(req, res, next) {
	knex.table('products').select('*').then(
		(data) => res.send(data)
	);
});

router.get('/category/:catid', function(req, res, next) {
	knex.table('products').select('*').where({category_id : req.params.catid}).then(
		(data) => res.send(data)
	);
});

router.get('/:id', function(req, res, next) {
	knex.table('products').select('*').where({id : req.params.id}).then(
		(data) => res.send(data[0])
	);
});

router.post('/', function(req, res, next) {
	knex.table('products').insert(req.body).then(
		(data) => res.send(data)
	);
});

module.exports = router;
