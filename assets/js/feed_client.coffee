{rquire, dfine} = window

#FeedList = document.FeedList
FeedList = rquire 'FeedList'
ItemList = rquire 'ItemList'
Feed = rquire 'Feed'
Item = rquire 'Item'
SimpleFeedsView = rquire 'SimpleFeedsView'

document.socket = socket = io.connect('http://localhost:3000')

document.feeds = feeds = new FeedList
dfine 'feeds', feeds

socket.on 'welcome', (data)=>
  # find out if I allready have an online model
  # communicate my id to server
  console.info 'welcome'
  socket.emit('init_model', "soon to be individual nickname")

socket.on 'refreshed_feed', (feed_json)->
  console.info 'refreshed_feed'
  console.log feed_json.title
  feed = new Feed feed_json
  feeds.add feed



document.app = app = new SimpleFeedsView {model: feeds, tagName: 'li', el: $ '#FeedsView'}
#app.render()

