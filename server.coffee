#!/usr/bin/env coffee

io       = require "socket.io"
repl     = require 'repl'
http     = require 'http'

app = require './app/main'
FeedGrabber = require "./feed_grabber"



server = (http.createServer app).listen 3000
io      = io.listen server

#require('repl').start { prompt: "app: ", input: process.stdin, output: process.stdout, useGlobal: yes }

global.allsockets = allsockets = []
feedGrabber = new FeedGrabber()
feedGrabber.on 'new_item', (item) =>
  sock.emit 'new_feed_item', item for sock in allsockets

# socket.io stuff
io.sockets.on "connection", (socket) ->
  allsockets.push socket

  socket.emit "welcome", hello: "world"

  socket.on "ping", (data) ->
    console.log data

  socket.on "start_grabbing", (data) ->
    setInterval (->feedGrabber.grabFeeds()), 15000

  socket.on "init_model", (data) ->
    feedGrabber.grabFeeds()



 

#repl.start { prompt: "Server: ", input: process.stdin, output: process.stdout, useGlobal: yes }
