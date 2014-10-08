arity = require "./arity"

module.exports = swap = ( fn, p1, p2 ) ->
  func = ->
    args = new Array arguments.length
    args[i] = arg for arg, i in arguments
    temp = args[p1]
    args[p1] = args[p2]
    args[p2] = temp
    fn.apply this, args
  arity func, fn.length
