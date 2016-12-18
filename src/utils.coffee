
# @param {Number} init
# @return {() => Number}
export createCounter = (init = 0) ->
  n = init
  -> n += 1

# @return {String}
export now = ->
  new Date().toLocaleString()

# @param {Number} min
# @param {Number} max
# @return {Number} [min, max)
export randomInRange = (min, max) ->
  min + Math.floor((max - min) * Math.random())

# @param {String} s
# @param {String} sub
# @return {Boolean}
export stringContains = (s, sub) ->
  (s.indexOf sub) > -1
