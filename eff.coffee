merge = ( target ) ->
  for source, i in arguments when i > 0
    target[key] = source[key] for own key of source
  target

curry = ( fn ) ->
  # outer = [].slice.call arguments
  len = arguments.length - 1
  outer = new Array len
  outer[i - 1] = arg for arg, i in arguments when i > 0
  curried = ->
    # args = outer.slice().concat [].slice.call arguments
    outerLen = outer.length
    len = arguments.length + outerLen
    args = new Array len
    args[i] = outerArg for outerArg, i in outer
    args[outerLen + j] = arg for arg, j in arguments
    if args.length >= fn.length
      fn.apply this, args
    else
      curry.apply null, [fn].concat args
  count = min0 fn.length - len
  arity curried, count

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

partialConstructor = ( Ctor ) ->
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
  arity func, min0 Ctor.length - outer.length

swap = ( fn, p1, p2 ) ->
  func = ->
    args = ( arg for arg in arguments )
    temp = args[p1]
    args[p1] = args[p2]
    args[p2] = temp
    fn.apply this, args
  arity func, fn.length

flip = ( fn ) ->
  swap fn, 0, 1

rotate = ( fn, count, dir = 1 ) ->
  throw new RangeError "direction parameter must be 1 or -1" unless dir is 1 or dir is -1
  func = ->
    len = arguments.length
    args = new Array len
    args[i] = arg for arg, i in arguments
    chunk = args.splice ( if dir is 1 then 0 else dir * count ), count
    fn.apply this, if dir is 1 then args.concat( chunk ) else chunk.concat( args )
  arity func, fn.length

firstToLast = ( fn ) ->
  rotate fn, 1

lastToFirst = ( fn ) ->
  rotate fn, 1, -1

reverse = ( fn ) ->
  func = ->
    len = arguments.length
    args = new Array len
    args[i] = arg for arg, i in arguments by -1
    fn.apply this, args.reverse()
  arity func, fn.length

demethodize = ( fn ) ->
  func = ( context ) ->
    args = []
    args.push arg for arg, i in arguments when i > 0
    fn.apply context, args
  arity func, fn.length + 1

# switch statements are extra suck in CoffeeScript
nAry = ( fn, n ) ->
  if n is 0
    -> fn.call this
  else if n is 1
    ( a ) -> fn.call this, a
  else if n is 2
    ( a, b ) -> fn.call this, a, b
  else if n is 3
    (a, b, c) -> fn.call this, a, b, c
  else if n is 4
    (a, b, c, d) -> fn.call this, a, b, c, d
  else if n is 5
    (a, b, c, d, e) -> fn.call this, a, b, c, d, e
  else if n is 6
    (a, b, c, d, e, f) -> fn.call this, a, b, c, d, e, f
  else if n is 7
    (a, b, c, d, e, f, g) -> fn.call this, a, b, c, d, e, f, g
  else if n is 8
    (a, b, c, d, e, f, g, h) -> fn.call this, a, b, c, d, e, f, g, h
  else if n is 9
    (a, b, c, d, e, f, g, h, i) -> fn.call this, a, b, c, d, e, f, g, h, i
  else if n is 10
    (a, b, c, d, e, f, g, h, i, j) -> fn.call this, a, b, c, d, e, f, g, h, i, j
  else
    throw new RangeError "Function must take 10 or fewer arguments"

arity = ( fn, n ) ->
  if n is 0
    -> fn.call this
  else if n is 1
    ( a ) -> fn.apply this, arguments
  else if n is 2
    ( a, b ) -> fn.apply this, arguments
  else if n is 3
    (a, b, c) -> fn.apply this, arguments
  else if n is 4
    (a, b, c, d) -> fn.apply this, arguments
  else if n is 5
    (a, b, c, d, e) -> fn.apply this, arguments
  else if n is 6
    (a, b, c, d, e, f) -> fn.apply this, arguments
  else if n is 7
    (a, b, c, d, e, f, g) -> fn.apply this, arguments
  else if n is 8
    (a, b, c, d, e, f, g, h) -> fn.apply this, arguments
  else if n is 9
    (a, b, c, d, e, f, g, h, i) -> fn.apply this, arguments
  else if n is 10
    (a, b, c, d, e, f, g, h, i, j) -> fn.apply this, arguments
  else
    throw new RangeError "Function must take 10 or fewer arguments"

unary = ( fn ) -> nAry fn, 1

binary = ( fn ) ->
  nAry fn, 2

module.exports =
  curry: curry
  arity: arity
  nAry: nAry
  unary: unary
  binary: binary
  swap: swap
  flip: flip
  reverse: reverse
  partial: partial
  partialConstructor: partialConstructor
  rotate: rotate
  firstToLast: firstToLast
  lastToFirst: lastToFirst

