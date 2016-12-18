
import cson from 'cson'
import { now } from './utils'

export class Logger

  constructor: ->
    # @type {{ [String]: State }}
    @records = {}
    # @type {Options}
    @options =
      silent: false

  # @type {State}
  initialState:
    count: 0
    error: undefined
    status: undefined
    time: now()

  # @param {String} url
  # @param {State} state
  updateState: (url, state) ->
    prevState = @records[url] ? @initialState
    nextState = Object.assign {}, prevState, state,
      count: prevState.count + 1
      time: now()
    @records[url] = nextState

  # @param {IncomingMessage} res
  # @param {String} status
  record: (url, res) ->
    @updateState url,
      error: undefined
      status: "#{res.statusCode} #{res.statusMessage}"
    if not @options.silent
      console.log '✓', url
      console.log ' ', res.statusCode, res.statusMessage

  # @param {String} url
  # @param {Error} error
  recordError: (url, error) ->
    @updateState url,
      status: undefined
      error: error.message
    if not @options.silent
      console.error '✗', url
      console.error ' ', error.message

  # @param {Options} options
  setOptions: (options) ->
    @options = Object.assign {}, @options, options

  # @return {String}
  show: ->
    cson.stringify @records

export logger = new Logger
