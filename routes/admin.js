var express = require('express');
var router = new express.Router();

var HashtagLayer = require('./hashtagLayer');

var auth = require('../helpers/auth');
var knex = require('../db/db.js');

/* GET OPEN SITE REQUEST. */
router.get('/site/open', (req, res) => {
  if(!auth.isAdmin(req)){

  	return res.sendStatus(403);
  }

  return knex.table('globals').where({ Name: 'MourgosIsLive' }).
  update({ Value: 1 }).
  then((data) => res.send(true)).
  catch((err) => res.send(err));
});

/* GET CLOSE SITE REQUEST. */
router.get('/site/close', (req, res) => {
  if(!auth.isAdmin(req)){

  	return res.sendStatus(403);
  }

  return knex.table('globals').where({ Name: 'MourgosIsLive' }).
  update({ Value: 0 }).
  then((data) => res.send(false)).
  catch((err) => res.send(err));
});


module.exports = router;