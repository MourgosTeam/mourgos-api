var url = 'http://www.mourgos.gr/?id=1';
var path = '/api/socket.io/';
var io = require('socket.io-client')(url, { path });
io.on('connect', () => {
 console.log('Connected');
});
io.on('new-order', () => {
 console.log('there is a new order');
});