
http = require 'http'
https = require 'https'

urls = require './urls'

containsArgs = (c) ->
  process.argv.some (ea) ->
    c.some (ec) ->
      ec == ea
args =
  view: containsArgs ['-v', '--view']
  test: containsArgs ['-t', '--test']

crtcounter = () ->
  n = 0
  () ->
    n += 1

crtlogger = (url) ->
  log = "0 - #{url}"
  count = crtcounter()
  (status, error) ->
    return log if !status? and !error?
    c = count()
    s = [-2..c.toString().length]
          .map () -> ' '
          .join ''
    log = "#{c} - #{url}"
    log += "\n#{s}status: #{status}" if status?
    log += "\n#{s}error: #{error}" if error?
    console.log log if args.view

log = {}

urls.forEach (url) ->
  log[url] = crtlogger(url)

log.logs = () ->
  urls
    .map (url) -> log[url]()
    .join '\n'

sendOnce = (url) ->
  (if -1 == url.indexOf 'https' then http else https)
    .get url, (res) ->
      log[url] res.statusCode
    .on 'error', (e) ->
      log[url] null, e.message

sendtoUrls = (urls) ->
  urls.forEach (url) ->
    # 1 or 2
    c = Math.round(Math.random() + 1)
    sendOnce(url) while (c -= 1) > 0

setto = (d) ->
  setTimeout () ->
      sendtoUrls urls
      # 10 to 20 minutes
      timeout =
        if args.test then 500
        else Math.round(1000 * 600 * (Math.random() + 1))
      setto timeout
    , d

setto 1
sendtoUrls urls

if containsArgs ['-b']
  port = process.env.PORT || 3000
  http
    .createServer (req, res) ->
      res.writeHeader 200,
        'Content-Type': 'text/plain'
      res.end log.logs()
    .listen port, () ->
      console.log "started"
      console.log "urls:"
      console.log urls
      console.log "listen on http://localhost:#{port}"
      console.log ""
