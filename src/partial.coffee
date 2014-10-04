partial = ( fn ) ->
  len = arguments.length - 1
  outer = new Array len
  outer[i - 1] = arg for arg, i in arguments when i > 0
  func = ->
    outerLen = outer.length
    len = arguments.length + outer.length
    args = new Array len
    args[i] = outerArg for outerArg, i in outer
    args[outerLen + i] = arg for arg, i in arguments
    fn.apply this, args
  arity func, min0 fn.length - outer.length