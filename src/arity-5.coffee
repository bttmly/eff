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
  else
    throw new RangeError "Function must take 5 or fewer arguments"