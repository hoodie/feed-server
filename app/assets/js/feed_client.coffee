console.info('hello')
FEED_MODEL = {}

document.socket = socket = io.connect('http://localhost:3000')
socket.on 'welcome', (data)=>
  console.log(data)
  socket.emit('init_model', "soon to be individual nickname")

socket.on 'new_feed_item', (item)->
  FEED_MODEL[item.feedid] ?= {}
  FEED_MODEL[item.feedid][item.id] ?= item
  console.log "#{item.feed_title}#{Object.keys(FEED_MODEL[item.feedid]).length} #{item.title}"


