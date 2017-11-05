var express = require('express');
var router = new express.Router();

/* GET home page. */
router.get('/', (req, res) => {
  res.send({ title: 'Express' });
});

module.exports = router;
