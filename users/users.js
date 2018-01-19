var knex = require('../db/db.js');
var express = require('express');
var app = new express.Router();
var CryptoJS = require('crypto-js');
var auth = require('../helpers/auth');

var ErrorHandler = require('./error-handler.js');
// /////////////////////////////////////////////////////////////////////
var included = {
email: 3,
id: 99,
// password : 2,
role: 5,
token: 4,
username: 1
};
function present(user) {
 var res = {};
 for (var key in user) {
  if (included[key]) {
  res[key] = user[key];
  }
 }

 return res;
}
// /////////////////////////////////////////////////////////////////////
function getUser(token) {
 return knex.table('users').select('*').
where({ token }).
then((data) => {
var [user] = data;
if (user === null) {
 throw Error('Not a valid token!');
} else {
 return user;
}
});
}

function middleware(req, res, next) {
var token = req.get('Token');
if (!token || token.length < 5) {
    next();

    return true;
}

return getUser(token).then((user) => {
 req.sessionUser = user;
 next();
}).
catch(() => {
 console.log('Session Users errors');
 next();
});

}
// /////////////////////////////////////////////////////////////////////
app.post('/role', (req, res) => {
    if (!auth.isAdmin(req)) {
        return res.sendStatus(403);
    }
    if (!req.body.role || !req.body.id) {
        return res.sendStatus(404);
    }

    return knex.table('users').
                where({ id: req.body.id }).
                update({ role: req.body.role }).
                then((updated) => {
                  const updates = updated;
                  if (updates !== 1) {
                    res.sendStatus(409);
                    const err = { status: 409 };

                    throw err;
                  }
                }).
                then(() => res.send({ msg: 'OK' }));
});
app.post('/register', (req, res) => {

    if (!auth.isAdmin(req)) {
        return res.sendStatus(403);
    }

    var theuser = {};

    return knex.table('users').select('*').
    where({ username: req.body.username }).
    then((data) => {
        var [ndata] = data;
        if (typeof ndata !== 'undefined' || ndata) {
            res.status(409);
            res.send(ErrorHandler.
                createError('Please choose another username or login!'));
            throw Error('Username exists');
        }
    }).
    then(() => {
    // create salt and hash
    console.log(req.body);
    var hashFn = CryptoJS.SHA256;

    var salt = CryptoJS.lib.WordArray.random(128 / 8).toString();
    var hash = hashFn(salt + req.body.password + salt).toString();
    var user = {
        email: req.body.email,
        name: req.body.name,
        password: hash,
        phone: req.body.phone,
        salt,
        username: req.body.username
    };
    theuser = user;

    return knex.table('users').insert(user);
    }).
    // register
    then(() => res.send(present(theuser)));
});

function checkUpdateToken(user) {
 var hashFn = CryptoJS.SHA256;
 var Token = user.token;
 var month = new Date().getMonth();
 if (month > 9) {
  month -= 10;
 }
 if (!user.token || parseInt(user.token[user.token.length - 1], 10) !== month) {
  // generate token
  Token = hashFn(Math.random().toString() + user.salt).toString() + month;
 }

return Token;
}
function checkGenerateToken(user, password) {
var hashFn = CryptoJS.SHA256;
var hash = hashFn(user.salt + password + user.salt).toString();
if (hash === user.password) {

var Token = checkUpdateToken(user);

return knex.table('users').where({ id: user.id }).
update('token', Token).
then(() => Token);
}

return Promise.reject(new Error('incorrect password'));

}

app.post('/login', (req, res) => {
    if (!req.body.username || !req.body.password) {
        res.status(400);
        res.send('Missing creds');

        return;
    }
    var theuser = {};
    knex.table('users').select('*').
    where({ username: req.body.username }).
    then((users) => {
        var [user] = users;
        theuser = user;
        if (!user) {
            throw Error({ 'msg': 'No username' });
        }

        return checkGenerateToken(user, req.body.password).
               then((token) => {
                    theuser.token = token;

                    return res.send(present(theuser));
        });
    }).
    catch(() => {
        res.status(403);
        res.send('Bad creds');
    });
});

app.get('/me', (req, res) => {
    var token = req.get('Token');
    if (!token) {
        res.status(400);
        res.send('Need a token...');

        return;
    }
    knex.table('users').select('*').
    where({ token }).
    then((users) => {
        var [user] = users;
        if (user === null) {
            res.status(400);
            res.send(ErrorHandler.createError('Invalid token!'));
        } else {
            res.send(present(user));
        }
    });
});

app.get('/', (req, res) => {
    if (!auth.isAdmin(req)) {
        res.sendStatus(403);

        return false;
    }

    return knex.table('users').select('*').
    then((users) => res.send(users));
});

app.get('/logout', (req, res) => {
knex.table('users').select('*').
where({ token: req.get('Token') }).
then((users) => {
var [user] = users;
if (user === null) {
res.status(400);
res.send(ErrorHandler.createError('Invalid token!'));
} else {
return knex.table('users').where({ id: user.id }).
update('Token', null);
}

return false;
}).
then((data) => res.send(data));
});

module.exports = {
App: app,
GetUser: getUser,
Middleware: middleware
};
