{rquire, dfine, Backbone} = window

FeedList = rquire 'FeedList'
Feed = rquire 'Feed'

feeds = rquire 'feeds'

class SimpleFeedsView extends Backbone.View

  @tagName : "li"

  initialize: ->
    @listenTo @model, 'add', @addOne

  addOne: (feed = new Feed()) ->
    @$el.append "<li>#{feed.get 'title'}</li>"

  render: ->

dfine SimpleFeedsView
