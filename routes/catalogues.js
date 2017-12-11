var express = require('express');
var router = new express.Router();

var auth = require('../helpers/auth');

var knex = require('../db/db.js');

/* GET users listing. */
router.get('/', (req, res) => {
  knex.table('catalogues').select('*').
  then((data) => {
    const newdata = [];
    const today = new Date().getDay();
    for (let ic = 0; ic < data.length; ic += 1) {
        const wd = JSON.parse(data[ic].WorkingDates);
        if (wd[today] === 1) {
            newdata.push(data[ic]);
        }
    }

    return newdata;
  }).
then((data) => res.send(data));
});

router.get('/my', (req, res) => {
 if (!auth.checkUser(req, res)) {

  return false;
 }

 return knex.table('catalogues').select('*').
 where({ user_id: req.sessionUser.id }).
 then((data) => res.send(data));

});


router.get('/id/:id', (req, res) => {
  knex.table('catalogues').select('*').
  where({ id: req.params.id }).
  then((data) => res.send(data[0]));
});

router.get('/:name', (req, res) => {
  knex.table('catalogues').select('*').
  where({ FriendlyURL: req.params.name }).
  then((data) => res.send(data[0]));
});

router.post('/', (req, res) => {
  res.sendStatus(500);

  return false;
  // knex.table('catalogues').insert(req.body).then((data) => res.send(data));
});

module.exports = router;
