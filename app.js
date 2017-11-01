var express = require('express');
var path = require('path');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var index = require('./routes/index');
var catalogues = require('./routes/catalogues');
var categories = require('./routes/categories');
var products = require('./routes/products');
var attributes = require('./routes/attributes');

var app = express();



app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// app.use('/', index);
app.use('/catalogues', catalogues);
app.use('/categories', categories);
app.use('/products', products);
app.use('/attributes', attributes);


module.exports = app;