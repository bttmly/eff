module.exports = arity5 = ( fn, n ) ->
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
  else
    throw new RangeError "Function must take 5 or fewer arguments"
