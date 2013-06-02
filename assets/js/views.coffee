#Backbone = window?.Backbone
#console.log Backbone.$ = $

FeedList = document?.FeedList
Feed     = document?.Feed
feeds = document?.feeds

class document.SimpleFeedsView extends Backbone.View

  @tagName : "li"

  initialize: ->
    @listenTo @model, 'add', @addOne

  addOne: (feed = new Feed()) ->
    @$el.append "<li>#{feed.get 'title'}</li>"

  render: ->
