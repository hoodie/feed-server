console.info('hello')
OLD_FEED_MODEL = {}

document.socket = socket = io.connect('http://localhost:3000')
socket.on 'welcome', (data)=>
  console.log(data)
  socket.emit('init_model', "soon to be individual nickname")

socket.on 'new_feed_item', (item)->
  OLD_FEED_MODEL[item.feedid] ?= {}
  unless OLD_FEED_MODEL[item.feedid][item.id]?
    OLD_FEED_MODEL[item.feedid][item.id] = item


