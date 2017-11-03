var express = require('express');
var router = express.Router();

var knex = require('../db/db.js');

/* GET users listing. */
router.get('/', function(req, res, next) {
	knex.table('catalogues').select('*').then(
		(data) => res.send(data)
	);
});
router.get('/:id', function(req, res, next) {
	knex.table('catalogues').select('*').where({id: req.params.id}).then(
		(data) => res.send(data[0])
	);
});

router.post('/', function(req, res, next) {
	knex.table('catalogues').insert(req.body).then(
		(data) => res.send(data)
	);
});

module.exports = router;
