# coffeelint: disable=cyclomatic_complexity

module.exports = nAry10 = ( fn, n ) ->
  n = 0 unless n > 0
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

# coffeelint: enable=cyclomatic_complexity
