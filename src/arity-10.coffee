# coffeelint: disable=cyclomatic_complexity

module.exports = arity10 = ( fn, n ) ->
  n = 0 unless n > 0
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

# coffeelint: enable=cyclomatic_complexity
