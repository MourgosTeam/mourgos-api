var express = require('express');
var router = new express.Router();

var auth = require('../helpers/auth');

var knex = require('../db/db.js');

/* GET categories listing. */
router.get('/', (req, res) => {
  knex.table('categories').select('*').
then((data) => res.send(data));
});

router.get('/my', (req, res) => {
if (!auth.checkUser(req, res)) {
 return;
}
 knex.table('catalogues').select('*').
where({ user_id: req.sessionUser.id }).
 then((data) => res.send(data));
});

router.get('/catalogue/:catid', (req, res) => {
  knex.table('categories').select('*').
where({ catalogue_id: req.params.catid }).
then((data) => res.send(data));
});

router.get('/:id', (req, res) => {
  knex.table('categories').select('*').
where({ id: req.params.id }).
then((data) => res.send(data[0]));
});

router.post('/', (req, res) => {
  knex.table('categories').insert(req.body).
then((data) => res.send(data));
});

module.exports = router;
