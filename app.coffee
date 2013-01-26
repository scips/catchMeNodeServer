io = require('socket.io').listen(8080)
data = {}
gameOn = false

io.sockets.on 'connection',(socket) ->
  io.sockets.emit 'debug', {message: 'received'}
  data[socket.id]={player: '',position: [0.0,0.0]}
  if data.length is 1 
    data[socket.id].player = "catch me"
  else
    data[socket.id].player = "I'll catch you"
    data[socket.id].position[0]+=0.0001
    data[socket.id].position[1]+=0.0001
  console.log "data item:"
  console.log data
  count = 0
  for item of data
    count++
  console.log count
  if count > 1
    console.log "emit gameon"
    gameOn = true
    console.log data
    io.sockets.emit 'gameon', data

  socket.on 'whoami', () ->
    socket.emit 'id',socket.id

  socket.on 'newgame', () ->
    console.log "new game requested"
    socket.emit('ok')

  socket.on 'joingame', () ->
    console.log "joingame requested"
    socket.emit('ok')

  socket.on 'position', (position) ->
    data[socket.id].position=position
    console.log "Position received #{data[socket.id].position}"
