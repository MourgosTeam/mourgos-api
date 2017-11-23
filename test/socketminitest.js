var io = require('socket.io-client')('http://localhost:3000?id=1');

io.on('connect', () => {
 console.log('Connected');
});
io.on('new-order', () => {
 console.log('there is a new order');
});