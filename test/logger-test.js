import test from 'ava'
import cson from 'cson'
import { Logger } from '../lib/logger'

let logger

test.before(t => {
  logger = new Logger
  t.is(logger.show(), '{}')
})

test('logger', t => {
  logger.setOptions({ silent: false })
  logger.record('url-normal', { statusCode: 200, statusMessage: 'OK' })
  logger.recordError('url-error', { message: 'connect ECONNREFUSED xxx' })

  const res = cson.parse(logger.show())

  t.is(res['url-normal'].count, 1)
  t.is(res['url-normal'].status, '200 OK')
  t.falsy(res['url-normal'].error)

  t.is(res['url-error'].count, 1)
  t.is(res['url-error'].error, 'connect ECONNREFUSED xxx')
  t.falsy(res['url-error'].status)
})
