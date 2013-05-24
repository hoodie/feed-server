class RssEntry
  constructor: (item)  ->
    @title       = item.getChild('title').getText()
    @description = "…"#item.getChild('description').getText()
    @guid        = item.getChild('guid').getText()
    @link        = item.getChild('link').getText()
    @pudDate     = @getPubDate item
    
   getPubDate: (item) ->
     pubdate = item.getChild('pubDate')?.getText()?


class module.exports.RssFeed
  constructor: (@el)  ->
    @getTitle()
    @getEntries()

  getEntries: ->
    channel = @el.getChild 'channel'
    items = channel.getChildren 'item'
    @entries = []

    for item,index in items
      entry = {}
      @entries.push new RssEntry item

  getTitle:  () ->
    @title = @el.getChild('channel').getChild('title').getText()


