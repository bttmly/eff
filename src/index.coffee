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

methods = {}

Object.keys( funcs ).forEach ( key ) ->
  methods[key] = ->
    args = new Array arguments.length + 1
    args[0] = this
    args[i + 1] = arg for arg, i in arguments
    funcs[key].apply null, args

extend = ( target, source ) ->
  target[key] = source[key] for key of source
  target

decorate = ( fn ) ->
  extend fn, methods

extend decorate, funcs

module.exports = decorate
