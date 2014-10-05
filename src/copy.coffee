arity = require "./arity"

module.exports = copy = ( fn ) ->
  func = ->
    fn.apply this, arguments
  arity func, fn.length
