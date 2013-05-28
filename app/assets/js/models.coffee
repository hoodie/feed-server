Backbone = require 'backbone' if module?

class ItemList extends Backbone.Collection

class Feed extends Backbone.Model
  constructor: (@nodepieFeed) ->
    @items = new ItemList()
  
    for item in @nodepieFeed.getItems()
      @items.add new Item item
  



class Item extends Backbone.Model
  constructor: (@nodepieItem)->
    @feed_title  = @nodepieItem.feed.getTitle()
    @title       = @nodepieItem.getTitle()
    @contents    = @nodepieItem.getContents()
    @description = @nodepieItem.getDescription()
    @permalink   = @nodepieItem.getPermalink()
    @author      = @nodepieItem.getAuthor()




module?.exports.Feed = Feed
document?.Feed       = Feed
module?.exports.Item = Item
document?.Item       = Item
