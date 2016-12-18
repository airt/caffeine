
import http from 'http'
import https from 'https'
import { logger } from './logger'
import { stringContains } from './utils'

# @param {String} url
export sendOne = (url) ->
  (if stringContains(url, 'https') then https else http).
    get(url, (res) -> logger.record(url, res)).
    on('error', (err) -> logger.recordError(url, err))

# @param {Array<String>} urls
export sendAll = (urls) ->
  urls.map(sendOne)
