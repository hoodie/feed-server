Backbone = window?.Backbone
document.socket = socket = io.connect('http://localhost:3000')

socket.on 'welcome', (data)=>
  # find out if I allready have an online model
  # communicate my id to server
  socket.emit('init_model', "soon to be individual nickname")

socket.on 'refreshed_feed', (feed)->
  console.log feed




