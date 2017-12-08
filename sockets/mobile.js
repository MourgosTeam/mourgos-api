var httpServer = require('http').Server;
var ioModule = require('socket.io');

var globalSocket = null;


// Double Spend on all channel
function sendToCatalogue(id, event, data) {
  const io = globalSocket;
  const sss = io.mysockets[id];
  if (sss && sss.length) {
    for (let ic = 0; ic < sss.length; ic += 1) {
      sss[ic].emit(event, data);
    }
  }
  const allch = io.mysockets.all;
  for (let ic = 0; ic < allch.length; ic += 1) {
    allch[ic].emit(event, data);
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
 var io = ioModule(http, {
  path,
  pingTimeout: 30000
 });

 io.mysockets = { all: [] };
 io.on('connection', onConnection);
 globalSocket = io;

 io.sendToCatalogue = sendToCatalogue;

return http;
}

module.exports = socketIt;