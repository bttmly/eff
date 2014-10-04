swap = require "./swap"

module.exports = flip = ( fn ) ->
  swap fn, 0, 1
