import path from 'path'
import program from 'commander'
import timeout from 'timeout-ts'

import project from '../package'

import { logger } from './logger'
import { sendAll } from './request'
import { runServer } from './server'

export run = (args) ->
  program.
    version(project.version).
    option('-l, --listen <port>', 'create server to show logs', parseInt).
    option('-i, --interval <minutes>', 'set sending interval', parseInt).
    option('-u, --urls <url>,<urls>', 'set urls', (urls) -> urls.split(',')).
    option('-f, --urls-file <file>', 'set urls file', 'config/urls.json').
    option('-o, --only-once', 'send requests only once').
    option('-s, --silent', 'silent mode').
    parse(args)

  logger.setOptions(silent: true) if program.silent?

  urls = program.urls ? require(path.resolve(__dirname, '..', program.urlsFile))

  doloop = ->
    sendAll(urls)
    interval = program.interval ? 10
    ms = interval * 1000 * 60
    timeout(ms).then(doloop) if not program.onlyOnce?

  doloop()

  runServer(program.listen) if program.listen?
