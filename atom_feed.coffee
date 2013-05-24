class AtomEntry
  constructor: (entry)  ->

class module.exports.AtomFeed
  constructor: (@el)  ->
    @getTitle()
    @getEntries()

  getEntries: ->
    entries = @el.getChildren 'entry'
    @entries = []

    for entry, index in entries
      @entries.push new AtomEntry entry

  getTitle:  () ->
    @title = @el.getChild('title').getText()


