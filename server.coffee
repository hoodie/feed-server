#!/usr/bin/env coffee

###
Module dependencies.
###

express = require "express"
http    = require "http"
path    = require "path"
io      = require "socket.io"

#request = require "request"
#NodePie = require 'nodepie'

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

# socket.io stuff
io.sockets.on "connection", (socket) ->
  socket.emit "news",
    hello: "world"

  socket.on "my other event", (data) ->
    console.log data

