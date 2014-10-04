arity = require "./arity"

module.exports = curry = ( fn ) ->
  len = arguments.length - 1
  outer = new Array len
  outer[i - 1] = arg for arg, i in arguments when i > 0
  curried = ->
    outerLen = outer.length
    len = arguments.length + outerLen
    args = new Array len
    args[i] = outerArg for outerArg, i in outer
    args[outerLen + j] = arg for arg, j in arguments
    if args.length >= fn.length
      fn.apply this, args
    else
      curry.apply null, [fn].concat args
  arity curried, fn.length - len
