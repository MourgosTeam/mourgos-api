var knex = require('../db/db.js');
var express = require("express");
var app = new express.Router();
var CryptoJS = require("crypto-js");


var ErrorHandler = require("./error-handler.js");
///////////////////////////////////////////////////////////////////////
var included = {
	id		 : 99,
	username : 1,
	//password : 2,
	email 	 : 3,
	token    : 4
};
function Present(user){
	var res = {};
	for(var i in user){
		if(included[i]){
			res[i] = user[i];
		}
	}
	return res;
}
///////////////////////////////////////////////////////////////////////
function getUser(token){
	var _token = token;
	return knex.table('users').select('*').where({token : _token}).
		then(function(data){
			var user = data[0];
			if(user == null){
				throw "Not a valid token!";
			}
			else{
				return user;
			}
		});
}

function middleware(req,res,next){
	var _token = req.get('Token');
	if(!_token || _token.length < 5)next();
	else getUser(_token).then((user)=>{
		req.sessionUser = user;
		next();
	}).catch((e)=> {
		console.log("Session Users errors");
		next();
	});
}
///////////////////////////////////////////////////////////////////////
app.post('/register', function (req, res) {
	var theuser = {};
	knex.table('users').select('*').where({username : req.body.username}).
	then(function (data){
		data = data[0];
		if(data != null){
			res.status(409);
			res.send(ErrorHandler.createError("Please choose another username or login! The username already exists.", req.body.username));
			throw "Username exists";
		}
	}).
	then(function(){
		// create salt and hash
		console.log(req.body);
		var salt = CryptoJS.lib.WordArray.random(128/8).toString();
		var hash = CryptoJS.SHA256(salt + req.body.password + salt).toString();
		var user = { 
			username: req.body.username,
			password: hash,
			email 	: req.body.email,
			salt 	: salt
		};
		theuser = user; 
		return knex.table('users').insert(user);
	}).
	// register
	then(function (data) {
		res.send(Present(theuser));
	}).catch(function(e){
		return;
	});
})

app.post('/login', function (req, res) {
	var theuser = {};
	knex.table('users').select('*').where({username : req.body.username}).
	then(function (users) {
		var user = theuser = users[0];
		if(!user)throw "No username";
		var hash = CryptoJS.SHA256(user.salt + req.body.password + user.salt).toString();
		if( hash === user.password ){
			//generate token
			var token = CryptoJS.SHA256(Math.random().toString() + user.salt).toString();
			theuser.token = token;
			return knex.table('users').where({id : user.id}).update('Token',  token);
		}
		else{ // bad pass
			res.status(400);
			res.send(ErrorHandler.createError("Invalid Credentials!"));
		}
	}).then(user => res.send(Present(theuser))).catch((e)=> {res.status(400);res.send("EROR");});
})

app.get('/me', function (req, res) {
	var _token = req.get('Token');
	if(!_token){
		res.status(400);
		res.send("Need a token...");
		return;
	}
	knex.table('users').select('*').where({token : _token}).
	then(function(users){
		var user = users[0];
		if(user === null){
			res.status(400);
			res.send(ErrorHandler.createError("Invalid token!"));
		}
		else{
			res.send(Present(user));
		}
	});
})

app.get('/logout', function (req, res) {
  	knex.table('users').select('*').where({token : req.get('Token')}).
	then(function(users){
		var user = users[0];
		if(user === null){
			res.status(400);
			res.send(ErrorHandler.createError("Invalid token!"));
		}
		else{
			return knex.table('users').where({id : user.id}).update('Token',  null);
		}
	}).
	then((data) => res.send(data));
})

module.exports = {
	App : app,
	getUser : getUser,
	Middleware:middleware
}