var express = require('express');
var router = new express.Router();

var auth = require('../helpers/auth');
var Logger = require('../helpers/logger');
var knex = require('../db/db.js');

/* POST home page. */
router.post('/mylocation', (req, res) => {
    if (!auth.isDelivery(req)) {
        return res.sendStatus(403);
    }

    const location = JSON.stringify(req.body);

    Logger.log(req, 'Location', location, '');

    return res.send({ msg: 'ok' });
});

router.get('/', (req, res) => {
    if (!auth.isAdmin(req)) {
        return res.sendStatus(403);
    }

    return knex('userlogs').select('*').
           then((data) => res.send(data));
});

router.get('/locations', (req, res) => {
    if (!auth.isAdmin(req)) {
        return res.sendStatus(403);
    }

    return knex('userlogs').where({ Type: 'Location' }).
           select('*').
           then((data) => res.send(data));
});

module.exports = router;