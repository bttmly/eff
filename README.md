# eff [![Build Status](https://travis-ci.org/nickb1080/eff.svg?branch=master)](https://travis-ci.org/nickb1080/eff)

Function decorators

### `eff(Function fn) -> Function`

### `eff.wrap(Function fn) -> Function`

## Methods
**All methods return functions.**

### Arity Altering Methods
#### `eff.arity(Function fn, Number n)`

#### `eff.nAry(Function fn, Number n)`

#### `eff.unary(Function fn)`
Equivalent to `eff.nAry(fn, 1)`.

#### `eff.binary(Function fn)`
Equivalent to `eff.nAry(fn, 2)`.

### Argument-Shifting Methods
#### `eff.flip(Function fn)`

#### `eff.swap(Function fn, Number pos1, Number pos2)`

#### `eff.rotate(Function fn, Number amount, [Number dir])`

#### `eff.firstToLast(Function fn)`
Equivalent to `eff.rotate(fn, 1)`.

#### `eff.lastToFirst(Function fn)`
Equivalent to `eff.rotate(fn, 1, -1)`.

### Currying and Partial Application
#### `eff.curry(Function fn, [args...])`

#### `eff.partial(Function fn, [args...])`

#### `eff.partialConstructor(Function fn, [args...])`

### Utilities
#### `eff.demethodize(Function fn)`