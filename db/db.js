var env = process.env.NODE_ENV || 'development';  
var config = require('./config/' + env + '.json');
var knex = require('knex')(config);

module.exports = knex;
