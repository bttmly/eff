curry = ( fn ) ->
  outer = [].slice.call( arguments, 1 )
  curried = ->
    args = outer.slice().concat( [].slice.call arguments )
    if args.length >= fn.length
      fn.apply this, args
    else
      curry.apply null, [fn].concat args
