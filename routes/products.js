var express = require('express');
var router = new express.Router();

var knex = require('../db/db.js');

function filterDate(data) {
  var day = new Date().getDay();
  var newArr = [];
  for (var ic = 0; ic < data.length; ic += 1) {
    if (data[ic].Days === null) {
      newArr.push(data[ic]);
    } else {
      var days = JSON.parse(data[ic].Days);
      if (days[day]) {
        newArr.push(data[ic]);
      }
    }
  }

return newArr;
}

/* GET users listing. */
router.get('/', (req, res) => {
  knex.table('products').select('*').
      then(filterDate).
      then((data) => res.send(data));
});

router.get('/category/:catid', (req, res) => {
  knex.table('products').select('*').
    where({ category_id: req.params.catid }).
    then(filterDate).
    then((data) => res.send(data));
});

router.get('/:id', (req, res) => {
  knex.table('products').select('*').
    where({ id: req.params.id }).
    then((data) => res.send(data[0]));
});

router.post('/', (req, res) => {
  knex.table('products').insert(req.body).
    then((data) => res.send(data));
});

module.exports = router;
