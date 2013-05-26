#!/usr/bin/env coffee

request = require 'request'
ltx     = require 'ltx'
clc     = require 'cli-color'
NodePie = require 'nodepie'

RssFeed = require('./rss_feed').RssFeed
AtomFeed = require('./atom_feed').AtomFeed

error      = (t) -> console.error clc.redBright.bold   "\n☠\n#{t}"
warn       = (t) -> console.log   clc.redBright.bold   "!#{t}"
info       = (t) -> console.log   clc.blueBright.bold  "#{t}"
success    = (t) -> console.log   clc.greenBright      "#{t}"
incomming  = (t) -> console.log   clc.xterm(120)       "\n→ #{t}"

FeedError = (@message) -> @name = "Feed Parsing Error"

feeds = {
  #golem_atom: 'http://rss.golem.de/rss.php?feed=ATOM1.0'
  #golem_rss: 'http://golem.de.dynamic.feedsportal.com/pf/578068/http://rss.golem.de/rss.php?feed=RSS1.0'
  #heise: 'http://heise.de.feedsportal.com/c/35207/f/653902/index.rss'
  heise_old: 'http://heise.de.feedsportal.com/c/35207/f/653901/index.rss'
  #heute: 'http://www.heute.de/ZDFheute-Nachrichten-Startseite-3998.html?view=rss'
  #spiegel: 'http://www.spiegel.de/index.rss'

}


parseResponse = (error, response, body)->
  unless error or response.statusCode != 200
    xml = body
    feed = new NodePie xml
    feed.init()
    console.log feed.getTitle()
    console.log feed.getDescription()
    item = feed.getItem(0)
    console.log item.getPermalink()


for name, feed of feeds
  request feed, parseResponse
  
