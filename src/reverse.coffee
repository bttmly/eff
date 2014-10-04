arity = require "./arity"

module.exports = reverse = ( fn ) ->
  func = ->
    len = arguments.length
    args = new Array len
    args[len - i - 1] = arg for arg, i in arguments by -1
    fn.apply this, args
  arity func, fn.length
