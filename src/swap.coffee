arity = require "./arity"

module.exports = swap = ( fn, p1, p2 ) ->
  func = ->
    args = new Array arguments.length
    args[i] = arg for arg, i in arguments
    a = args[p1]
    b = args[p2]
    args[p2] = a
    args[p1] = b
    fn.apply this, args
  arity func, fn.length
