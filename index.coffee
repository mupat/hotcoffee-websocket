EventEmitter = require('events').EventEmitter

class Socket extends EventEmitter
  constructor: (@app, @opts = {}) ->
    @name = 'websocket'

    @io = @opts.io || require('socket.io') @app.server
    @io.on 'connection', @_connected.bind @
    @_registerEvents()

  _connected: (socket) ->
    @emit 'client', 'connected'

    socket.on 'disconnect', =>
      @emit 'client', 'disconnected'

  _registerEvents: ->
    @app.on 'POST', @_emitEvents.bind @, 'post'
    @app.on 'PATCH', @_emitEvents.bind @, 'patch'
    @app.on 'DELETE', @_emitEvents.bind @, 'delete'

  _emitEvents: (method, resource, data) ->
    @io.emit method, resource, data

module.exports = (app, opts) ->
  return new Socket app, opts
