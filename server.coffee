#!/usr/bin/env coffee

###
Module dependencies.
###

express = require "express"
http    = require "http"
path    = require "path"
io      = require "socket.io"

request = require "request"
NodePie = require 'nodepie'

routes  = require "./routes"
user    = require "./routes/user"

app = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", __dirname + "/views"
app.set "view engine", "jade"
app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use(express.static(__dirname + '/public'))

# development only
app.use express.errorHandler()  if "development" is app.get("env")
app.get "/", routes.index
app.get "/users", user.list
server = http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
io      = io.listen server

#require('repl').start { prompt: "app: ", input: process.stdin, output: process.stdout, useGlobal: yes }

allsockets = []
# socket.io stuff
io.sockets.on "connection", (socket) ->

  socket.emit "news",
    hello: "world"

  socket.on "my other event", (data) ->
    console.log data

  allsockets.push socket




# feed stuff
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

