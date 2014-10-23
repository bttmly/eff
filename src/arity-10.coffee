# coffeelint: disable=cyclomatic_complexity

# borrowed from Ramda
module.exports = arity10 = ( fn, n ) ->
  n = 0 unless n > 0
  if n is 0
    -> fn.call this
  else if n is 1
    ( a ) -> a; fn.apply this, arguments
  else if n is 2
    ( a, b ) -> b; fn.apply this, arguments
  else if n is 3
    (a, b, c) -> c; fn.apply this, arguments
  else if n is 4
    (a, b, c, d) -> d; fn.apply this, arguments
  else if n is 5
    (a, b, c, d, e) -> e; fn.apply this, arguments
  else if n is 6
    (a, b, c, d, e, f) -> f; fn.apply this, arguments
  else if n is 7
    (a, b, c, d, e, f, g) -> g; fn.apply this, arguments
  else if n is 8
    (a, b, c, d, e, f, g, h) -> h; fn.apply this, arguments
  else if n is 9
    (a, b, c, d, e, f, g, h, i) -> i; fn.apply this, arguments
  else if n is 10
    (a, b, c, d, e, f, g, h, i, j) -> j; fn.apply this, arguments
  else
    throw new RangeError "Function must take 10 or fewer arguments"

# coffeelint: enable=cyclomatic_complexity
