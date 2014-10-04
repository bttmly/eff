arity = require "./arity"

module.exports = partialConstructor = ( Ctor ) ->
  len = arguments.length - 1
  outer = new Array len
  outer[i - 1] = arg for arg, i in arguments when i > 0
  func = ->
    outerLen = outer.length
    len = arguments.length + outer.length
    args = new Array len
    args[i] = outerArg for outerArg, i in outer
    args[outerLen + i] = arg for arg, i in arguments
    obj = Object.create Ctor::
    result = Ctor.apply obj, args
    if result and typeof result is "object" or typeof result is "function"
      result
    else
      obj
  arity func, Ctor.length - outer.length
