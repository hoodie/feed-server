if module?
  Backbone = require 'backbone'
else
  Backbone = window?.Backbone

class ItemList extends Backbone.Collection


class Item extends Backbone.Model
  initialize: (@nodepieItem)->

  loadPie: (@nodepieItem)->
    @set "feed_title"  , @nodepieItem.feed.getTitle()
    @set "title"       , @nodepieItem.getTitle()
    @set "date"        , @nodepieItem.getDate()
    @set "updateDate"  , @nodepieItem.getUpdateDate()
    @set "contents"    , @nodepieItem.getContents()
    @set "description" , @nodepieItem.getDescription()
    @set "permalink"   , @nodepieItem.getPermalink()
    @set "alternate"   , @nodepieItem.getPermalink('alternate', 'text/html')
    @set "author"      , @nodepieItem.getAuthor()
    @set "authors"     , @nodepieItem.getAuthors()




class Feed extends Backbone.Model

  defaults: ->
    title: "empty feed"

  initialize: ->
    @items = new ItemList()

  toJSON: ->
    json = super()
    json.items = @items.toJSON()
    json

  loadPie: (@nodepieFeed) ->

    if @nodepieFeed?
      @set "title"       , @nodepieFeed.getTitle()
      @set "encoding"    , @nodepieFeed.getEncoding()
      @set "description" , @nodepieFeed.getDescription()
      @set "permalink"   , @nodepieFeed.getPermalink()
      @set "hub"         , @nodepieFeed.getHub()
      @set "self"        , @nodepieFeed.getSelf()
      @set "image"       , @nodepieFeed.getImage()
      @set "date"        , @nodepieFeed.getDate()
      #@set "link"       , @nodepieFeed.get()

      for item in @nodepieFeed.getItems()
        bbitem = new Item()
        bbitem.loadPie item
        @items.add bbitem
  



module?.exports.Feed = Feed
document?.Feed       = Feed
module?.exports.Item = Item
document?.Item       = Item
