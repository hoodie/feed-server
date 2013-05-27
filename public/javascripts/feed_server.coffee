console.info('hello')

socket = io.connect('http://localhost:3000')
socket.on 'welcome', (data)->
  console.log(data)
  socket.emit('init feed model', "soon to be individual nickname")
