Feed = document.Feed
FeedList = document.FeedList
Item = document.Item
ItemList = document.ItemList
SimpleFeedsView = document.SimpleFeedsView

document.socket = socket = io.connect('http://localhost:3000')

document.feeds = feeds = new FeedList

socket.on 'welcome', (data)=>
  # find out if I allready have an online model
  # communicate my id to server
  console.info 'welcome'
  socket.emit('init_model', "soon to be individual nickname")

socket.on 'refreshed_feed', (feed_json)->
  console.info 'refreshed_feed'
  feed = new Feed feed_json
  feeds.add feed



document.app = app = new SimpleFeedsView {model: feeds, tagName: 'li', el: $ '#FeedsView'}
app.render()

