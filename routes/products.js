var express = require('express');
var router = new express.Router();

var knex = require('../db/db.js');

function filterDate(data) {
  var day = new Date().getDay();
  var newArr = [];
  for(var i=0;i<data.length;i++){
    if(data[i].Days === null){
      newArr.push(data[i]);
    }
    else{
      var days = JSON.parse(data[i].Days);
      if(days[day])newArr.push(data[i]);
    }
  }
  return newArr;
}

/* GET users listing. */
router.get('/', (req, res) => {
  knex.table('products').select('*')
    .then(filterDate)
    .then((data) => res.send(data));
});

router.get('/category/:catid', (req, res) => {
  knex.table('products').select('*')
    .where({ category_id: req.params.catid })
    .then(filterDate)
    .then((data) => res.send(data));
});

router.get('/:id', (req, res) => {
  knex.table('products').select('*')
    .where({ id: req.params.id })
    .then((data) => res.send(data[0]));
});

router.post('/', (req, res) => {
  knex.table('products').insert(req.body)
    .then((data) => res.send(data));
});

module.exports = router;
