arity = require "./arity"

module.exports = rotate = ( fn, count, dir = 1 ) ->
  throw new RangeError "direction parameter must be 1 or -1" unless dir is 1 or dir is -1
  func = ->
    args = new Array arguments.length
    args[i] = arg for arg, i in arguments
    chunk = args.splice ( if dir is 1 then 0 else dir * count ), count
    fn.apply this, if dir is 1 then args.concat( chunk ) else chunk.concat( args )
  arity func, fn.length
