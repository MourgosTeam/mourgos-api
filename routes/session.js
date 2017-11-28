var express = require('express');
var router = new express.Router();
var auth = require('../helpers/auth');

router.get('/session', (req, res) => {
 if (auth.checkUser(req, res) === false) {
  res.sendStatus(403);
 } else {
  res.sendStatus(200);
 }
});

module.exports = router;