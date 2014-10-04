Function::bind or= require "function-bind"
should = require( "chai" ).should()

{
  curry,
  partial,
  partialRight,
  partialConstructor,
  flip,
  swap,
  reverse,
  firstToLast,
  lastToFirst,
  unary,
  binary,
  arity,
  nAry,
} = require "eff"

addTwo = (a, b) ->
  a + b

addThree = (a, b, c) ->
  a + b + c

addFour = (a, b, c, d) ->
  a + b + c + d

curryAddFour = undefined
curryAddFour_1 = undefined
curryAddFour_1_2 = undefined
curryAddFour_1_2_3 = undefined
curryAddFour_1_2_5 = undefined

beforeEach ->
  curryAddFour = curry addFour
  curryAddFour_1 = curryAddFour(1)
  curryAddFour_1_2 = curryAddFour_1(2)
  curryAddFour_1_2_3 = curryAddFour_1_2(3)
  curryAddFour_1_2_5 = curryAddFour_1_2(5)

describe "curry()", ->
  it "should return a function always", ->
    curry( addFour, 1, 2, 3, 4 ).should.be.a "function"

  it "should return functions which continue to return functions until their arguments are filled", ->
    curryAddFour.should.be.a "function"
    curryAddFour_1.should.be.a "function"
    curryAddFour_1_2.should.be.a "function"
    curryAddFour_1_2_3.should.be.a "function"
    curryAddFour_1_2_5.should.be.a "function"
    ten = curryAddFour_1_2_3(4)
    fourteen = curry(addFour)(2)(3)(4)(5)
    fifteen = curryAddFour_1_2_5(7)
    ten.should.equal 10
    fourteen.should.equal 14
    fifteen.should.equal 15

  it "should return functions with the proper length", ->
    curryAddFour.length.should.equal 4
    curryAddFour_1.length.should.equal 3
    curryAddFour_1_2.length.should.equal 2
    curryAddFour_1_2_3.length.should.equal 1
    curryAddFour_1_2_3_4 = curry addFour, 1, 2, 3, 4
    curryAddFour.length.should.equal 0





