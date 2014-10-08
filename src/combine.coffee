arity = require "./arity"

module.exports = ( dir ) ->
  args = new Array arguments.length - 1
  args[i - 1] = arg for arg, i in arguments when i isnt 0
  len = args[1].length
  func = ->
    i = if dir is 1 then 0 else arguments.length - 1
    ret = args[i].apply( this, arguments )
    while ( i += dir ) < args.length
      ret = args[i].call( this, ret )
    ret
  arity func, len