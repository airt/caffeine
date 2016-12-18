
import http from 'http'
import { logger } from './logger'

# @param {Number} port
export runServer = (port) ->
  server = http.createServer (req, res) ->
    res.writeHeader 200,
      'Content-Type': 'text/plain'
    res.end logger.show()

  server.listen port, ->
    console.log "listen on http://localhost:#{port}"
