arity = require "./arity.coffee"

module.exports = reverse = ( fn ) ->
  func = ->
    len = arguments.length
    args = new Array len
    args[i + 1 - len] = arg for arg, i in arguments by -1
    fn.apply this, args
  arity func, fn.length
