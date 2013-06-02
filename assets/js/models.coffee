if module?
  Backbone = require 'backbone'
  {rquire, dfine} = require './dfine'
else
  {rquire, dfine, Backbone} = window


class FeedList extends Backbone.Collection
  model: Feed

class ItemList extends Backbone.Collection
  model: Item


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
    console.log @get 'title'
    @items = new ItemList()

    items_json = @get 'items_json'
    if @items_json?
      for item in items_json
        @items.add new Item item


  toJSON: ->
    json = super()
    json.items_json = @items.toJSON()
    json

  loadPie: (@nodepieFeed) ->
    if @nodepieFeed?
      @set "id"       , @nodepieFeed.getTitle()
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
  

exports = dfine {FeedList, ItemList, Feed, Item}
module.exports = exports if module?

