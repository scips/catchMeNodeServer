io = require('socket.io').listen(8080)

io.sockets.on 'connection',(socket) ->
  io.sockets.emit 'debug', {message: 'received'}

  socket.on 'newgame', () ->
    console.log "new game requested"
    socket.emit('ok')

  socket.on 'joingame', () ->
    console.log "joingame requested"
    socket.emit('ok')
