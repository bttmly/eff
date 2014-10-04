nAry = (n, fn) ->
  switch n
    when 0
      return ->
        fn.call this
    when 1
      return (a) ->
        fn.call this, a
    when 2
      return (a, b) ->
        fn.call this, a, b
    when 3
      return (a, b, c) ->
        fn.call this, a, b, c
    when 4
      return (a, b, c, d) ->
        fn.call this, a, b, c, d
    when 5
      return (a, b, c, d, e) ->
        fn.call this, a, b, c, d, e
    when 6
      return (a, b, c, d, e, f) ->
        fn.call this, a, b, c, d, e, f
    when 7
      return (a, b, c, d, e, f, g) ->
        fn.call this, a, b, c, d, e, f, g
    when 8
      return (a, b, c, d, e, f, g, h) ->
        fn.call this, a, b, c, d, e, f, g, h
    when 9
      return (a, b, c, d, e, f, g, h, i) ->
        fn.call this, a, b, c, d, e, f, g, h, i
    when 10
      return (a, b, c, d, e, f, g, h, i, j) ->
        fn.call this, a, b, c, d, e, f, g, h, i, j
    else
      throw new RangeError("Pass a function with length of 10 or less.")
  return
arity = (n, fn) ->
  switch n
    when 0
      ->
        fn.apply this, arguments_
    when 1
      (a) ->
        fn.apply this, arguments_
    when 2
      (a, b) ->
        fn.apply this, arguments_
    when 3
      (a, b, c) ->
        fn.apply this, arguments_
    when 4
      (a, b, c, d) ->
        fn.apply this, arguments_
    when 5
      (a, b, c, d, e) ->
        fn.apply this, arguments_
    when 6
      (a, b, c, d, e, f) ->
        fn.apply this, arguments_
    when 7
      (a, b, c, d, e, f, g) ->
        fn.apply this, arguments_
    when 8
      (a, b, c, d, e, f, g, h) ->
        fn.apply this, arguments_
    when 9
      (a, b, c, d, e, f, g, h, i) ->
        fn.apply this, arguments_
    when 10
      (a, b, c, d, e, f, g, h, i, j) ->
        fn.apply this, arguments_
    else
      throw new RangeError("Pass a function with length of 10 or less.")
  return
unary = (fn) ->
  (a) ->
    fn.call this, a
binary = (fn) ->
  (a, b) ->
    fn.call this, a, b
unarity = (fn) ->
  (a) ->
    fn.apply this, arguments_
binarity = (fn) ->
  (a, b) ->
    fn.apply this, arguments_
swap = (fn, pos1, pos2) ->
flip = (fn, all) ->
  func = undefined
  if all
    func = ->
      a = undefined
      b = undefined
      temp = undefined
      len = arguments_.length
      args = new Array(arguments_.length)
      i = 0

      while i < len
        args[i] = arguments_[i]
        i++
      a = args.shift()
      b = args.shift()
      args.unshift a
      args.unshift b
      fn.call this, args
  func
