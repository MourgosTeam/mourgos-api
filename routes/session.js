var express = require('express');
var router = new express.Router();
var auth = require('../helpers/auth');

router.get('/session', (req, res) => {
 if (auth.checkUser(req, res) === true) {
  res.sendStatus(200);
 }
});

module.exports = router;