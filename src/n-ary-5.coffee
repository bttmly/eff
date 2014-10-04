module.exports = nAry5 = ( fn, n ) ->
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
  else
    throw new RangeError "Function must take 5 or fewer arguments"
