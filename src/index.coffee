extend = ( target, source ) ->
  target[key] = source[key] for key of source
  target

module.exports = decorate = ( fn ) ->
  extend( fn, methods )

methods = {}

funcs =
  curry: require "./curry"
  arity: require "./arity"
  nAry: require "./n-ary"
  unary: require "./unary"
  binary: require "./binary"
  swap: require "./swap"
  flip: require "./flip"
  reverse: require "./reverse"
  partial: require "./partial"
  partialConstructor: require "./partial-constructor"
  rotate: require "./rotate"
  firstToLast: require "./first-to-last"
  lastToFirst: require "./last-to-first"
  demethodize: require "./demethodize"
  copy: require "./copy"
  # compose: require "./compose"
  # sequence: require "./sequence"

Object.keys( funcs ).forEach ( key ) ->
  methods[key] = decorate ->
    args = new Array( arguments.length + 1 )
    args[0] = this
    args[i + 1] = arg for arg, i in arguments
    ret = funcs[key].apply null, args
    if typeof ret is "function" then decorate( ret ) else ret

extend( decorate, funcs )
