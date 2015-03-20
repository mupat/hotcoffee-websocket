should = require 'should'
sinon = require 'sinon'
EventEmitter = require('events').EventEmitter
Plugin = require "#{__dirname}/../index"

describe 'plugin websocket', ->
  beforeEach ->
    @app = new EventEmitter()
    @io = new EventEmitter()
    @plugin = new Plugin @app, {io: @io}

  it 'should provide the correct name', ->
    @plugin.name.should.equal 'websocket'

  it 'should emit client connected, if there is a new connection', (done) ->
    @plugin.on 'client', (status) ->
      status.should.equal 'connected'
      done()
    @io.emit 'connection', new EventEmitter()

  it 'should emit client disconnected, if there is a connection removed', (done) ->
    @plugin.on 'client', (status) ->
      return if status is 'connected'
      status.should.equal 'disconnected'
      done()
    socket = new EventEmitter()
    @io.emit 'connection', socket
    socket.emit 'disconnect'

  it 'should emit the post event', (done) ->
    @io.on 'post', (resource, data) ->
      resource.should.equal 'new'
      data.should.eql { test: 'test' }
      done()
    @app.emit 'POST', 'new', { test: 'test' }

  it 'should emit the patch event', (done) ->
    @io.on 'patch', (resource, data) ->
      resource.should.equal 'new'
      data.should.eql { test: 'test' }
      done()
    @app.emit 'PATCH', 'new', { test: 'test' }

  it 'should emit the delete event', (done) ->
    @io.on 'delete', (resource, data) ->
      resource.should.equal 'new'
      data.should.eql { test: 'test' }
      done()
    @app.emit 'DELETE', 'new', { test: 'test' }
