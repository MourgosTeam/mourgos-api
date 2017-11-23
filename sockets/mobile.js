var httpServer = require('http').Server;
var ioModule = require('socket.io');

var globalSocket = null;


function sendToCatalogue(id, event, data) {
  var io = globalSocket;
  var sss = io.mysockets[id];
  if (!sss || !sss.length) {
 return false;
  }
  for (var ic = 0; ic < sss.length; ic += 1) {
    sss[ic].emit(event, data);
  }

return true;
}
function onConnection(socket) {
  var io = globalSocket;
  var catid = socket.handshake.query.id;
  if (!catid) {
 socket.disconnect();
}
  if (!io.mysockets[catid]) {
io.mysockets[catid] = [];
}
  const position = io.mysockets[catid].length;
  io.mysockets[catid].push(socket);
  socket.on('disconnect', () => io.mysockets[catid].splice(position, 1));
}

function socketIt(app, path) {
 if (!app) {
  return globalSocket;
}
 var http = httpServer(app);
 var io = ioModule(http, { path });

 io.mysockets = {};
 io.on('connection', onConnection);
 globalSocket = io;

 io.sendToCatalogue = sendToCatalogue;

return http;
}

module.exports = socketIt;