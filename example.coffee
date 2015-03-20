hotcoffee = require('hotcoffee')()
websocket = require "#{__dirname}/index"

hotcoffee
  .use(websocket)

hotcoffee.plugins['websocket'].on 'client', (status) ->
  console.log "client #{status}"

hotcoffee.plugins['websocket'].on 'failure', (err) ->
  console.log 'err', err

hotcoffee.start()
