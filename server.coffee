#!/usr/bin/env coffee

request = require 'request'
ltx     = require 'ltx'
clc     = require 'cli-color'
RssFeed = require('./rss_feed').RssFeed
AtomFeed = require('./atom_feed').AtomFeed

error      = (t) -> console.error clc.redBright.bold   "\n☠\n#{t}"
warn       = (t) -> console.log   clc.redBright.bold   "!#{t}"
info       = (t) -> console.log   clc.blueBright.bold  "#{t}"
success    = (t) -> console.log   clc.greenBright      "#{t}"
incomming  = (t) -> console.log   clc.xterm(120)       "\n→ #{t}"

FeedError = (@message) -> @name = "Feed Parsing Error"

KNOWN_FORMATS = {
  'http://www.w3.org/2005/Atom': 'ATOM'
  'http://www.w3.org/1999/02/22-rdf-syntax-ns#': 'RSS'
  rss: 'RSS'
  rss09: 'RSS'
  rss10: 'RSS'
  rss11: 'RSS'
  rss20: 'RSS'
}

feeds = {
  #golem_atom: 'http://rss.golem.de/rss.php?feed=ATOM1.0'
  #golem_rss: 'http://golem.de.dynamic.feedsportal.com/pf/578068/http://rss.golem.de/rss.php?feed=RSS1.0'
  #heise: 'http://heise.de.feedsportal.com/c/35207/f/653902/index.rss'
  heise_old: 'http://heise.de.feedsportal.com/c/35207/f/653901/index.rss'
  #heute: 'http://www.heute.de/ZDFheute-Nachrichten-Startseite-3998.html?view=rss'
  #spiegel: 'http://www.spiegel.de/index.rss'

}

identifyFormat = (el) ->
    ns = el.getNS()
    format =
      if ns of KNOWN_FORMATS
        KNOWN_FORMATS[ns]
      else if el.attrs['xmlns:rdf']?
        KNOWN_FORMATS[el.attrs['xmlns:rdf']]
      else if el.getName() == 'rss'
        KNOWN_FORMATS['rss']
      else
        undefined

parse = (body) -> ltx.parse body

parseResponse = (error, response, body)->
  unless error or response.statusCode != 200
    el = parse body
    #console.log Object.keys response
    format = identifyFormat el
    feed = switch format
      when 'RSS'  then new RssFeed el
      when 'ATOM' then new AtomFeed el
    info feed.title
    console.log feed

for name, feed of feeds
  request feed, parseResponse
  
