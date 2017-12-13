var express = require('express');
var router = new express.Router();

var auth = require('../helpers/auth');
var Logger = require('../helpers/logger');

/* POST home page. */
router.post('/mylocation', (req, res) => {
    if (!auth.isDelivery(req)) {
        return res.sendStatus(403);
    }

    const location = JSON.stringify(req.body);

    Logger.log(req, location, 'Location', '');

    return res.send({ msg: 'ok' });
});

module.exports = router;