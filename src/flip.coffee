swap = require "./swap.coffee"

flip = ( fn ) ->
  swap fn, 0, 1
