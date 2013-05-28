#!/usr/bin/env coffee

clc        = require 'cli-color'
error      = (t) -> console.error clc.redBright.bold   "\n☠\n#{t}"
warn       = (t) -> console.log   clc.redBright.bold   "!#{t}"
info       = (t) -> console.log   clc.blueBright.bold  "#{t}"

crypto  = require "crypto"
repl    = require 'repl'
request = require "request"
backbone = require 'backbone'
Feed    = require("./app/assets/js/models").Feed
Item    = require("./app/assets/js/models").Item

NodePie = require 'nodepie'
EventEmitter = require('events').EventEmitter

class FeedGrabber
  constructor: ->
    @events = new EventEmitter

  on: ->
    @events.on.apply @events, arguments

  hash: (string) -> crypto.createHash('sha1').update(string).digest('hex')

  MODEL: {}

# feed stuff
  FEEDS:
    golem_atom: 'http://rss.golem.de/rss.php?feed=ATOM1.0'
    #golem_rss: 'http://golem.de.dynamic.feedsportal.com/pf/578068/http://rss.golem.de/rss.php?feed=RSS1.0'
    heise: 'http://heise.de.feedsportal.com/c/35207/f/653902/index.rss'
    #heise_old: 'http://heise.de.feedsportal.com/c/35207/f/653901/index.rss'
    heute: 'http://www.heute.de/ZDFheute-Nachrichten-Startseite-3998.html?view=rss'
    spiegel: 'http://www.spiegel.de/index.rss'

  sortin: (feed) =>
    hfeed = @hash feed.getTitle()
    @MODEL[hfeed] ?= {}

    for item in feed.getItems()
      if item.getTitle() and item.getPermalink()
        hitem = @hash item.getPermalink()
        @MODEL[hfeed][hitem] ?= item

        @events.emit 'new_item', @pacify_item item

  pacify_item: (item) ->
    {
      feedid      : @hash item.feed.getTitle()
      id          : @hash item.getPermalink()
      feed_title  : item.feed.getTitle()
      title       : item.getTitle()
      contents    : item.getContents()
      description : item.getDescription()
      permalink   : item.getPermalink()
      author      : item.getAuthor()
    }

  grabFeed: (feed_url = @TEST_FEED)=>
    request feed_url, parseResponse = (error, response, xml)=>
      unless error or response.statusCode != 200
        feed = new NodePie xml
        feed.init()
        @events.emit 'refreshed_feed', feed
        console.log feed.getTitle()
        @sortin feed


  grabFeeds: ->
    for name, feed_url of @FEEDS
      @grabFeed feed_url
      

module.exports = FeedGrabber
#global.fb = new FeedGrabber()
#fb.grabFeed(fb.TEST_FEED)
#repl.start { prompt: "FeedGrabber: ", input: process.stdin, output: process.stdout, useGlobal: yes }
