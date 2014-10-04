Function::bind or= require "function-bind"
should = require( "chai" ).should()

{ curry,
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
  nAry } = require "./eff.coffee"

addTwo = (a, b) ->
  a + b

addThree = (a, b, c) ->
  a + b + c

addFour = (a, b, c, d) ->
  a + b + c + d

map = ( arr, cb ) ->
  cb item, i, arr for item, i in arr

filter = ( arr, cb ) ->
  item for item, i in arr when cb item, i arr


describe "curry()", ->
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
    curryAddFour_1_2_3_4.length.should.equal 0

describe "swap", ->
  contrived = (a, b, c, d, e, f, g, h) -> c + h
  swapContrived = swap contrived, 2, 7

  it "should swap the position of any two arguments", ->
    contrived( "", "", "abc", "", "", "", "", "xyz" ).should.equal "abcxyz"
    swapContrived( "", "", "abc", "", "", "", "", "xyz" ).should.equal "xyzabc"

  it "should preserve the arity of the original function", ->
    swapContrived.length.should.equal 8

describe "flip", ->
  nums = [1, 2, 3]
  times2 = ( n ) -> n * 2
  it "should swap the position of the first two arguments", ->
    map( nums, times2 ).should.deep.equal [2, 4, 6]
    flip( map )( times2, nums ).should.deep.equal [2, 4, 6]

  it "should preserve the arity of the original function", ->
    flip( ( a, b, c, d, e, f ) -> ).length.should.equal 6

describe "partialConstructor", ->

  class Building
    constructor: (color, sqFt) ->
      @color = color
      @sqFt = sqFt
    buildingMethod: ->

  WhiteBuilding = partialConstructor Building, "white"
  BigWhiteBuilding = partialConstructor WhiteBuilding, 10000

  class House extends Building
    constructor: (color, sqFt, bedrooms) ->
      super
      @bedrooms = bedrooms
    houseMethod: ->

  BlueHouse = partialConstructor House, "blue"
  BigBlueHouse = partialConstructor BlueHouse, 4000
  BigBlueFamilyHouse = partialConstructor BigBlueHouse, 6

  it "should work properly called on a constructor once", ->
    whtBldg = new WhiteBuilding 3000
    whtBldg.should.be.instanceof Building
    whtBldg.color.should.equal "white"
    whtBldg.sqFt.should.equal 3000
    whtBldg.buildingMethod.should.be.a "function"

  it "should support repeated partial application", ->
    bgWhtBldg = new BigWhiteBuilding()
    bgWhtBldg.should.be.instanceof Building
    bgWhtBldg.color.should.equal "white"
    bgWhtBldg.sqFt.should.equal 10000
    bgWhtBldg.buildingMethod.should.be.a "function"

  it "should support subclassing", ->
    blHouse = new BlueHouse 1500, 3
    blHouse.should.be.instanceof House
    blHouse.should.be.instanceof Building
    blHouse.color.should.equal "blue"
    blHouse.sqFt.should.equal 1500
    blHouse.bedrooms.should.equal 3
    blHouse.buildingMethod.should.be.a "function"
    blHouse.houseMethod.should.be.a "function"

  it "support repeated partial application for subclassing", ->
    bgBlHouse = new BigBlueHouse 5
    bgBlHouse.should.be.instanceof House
    bgBlHouse.should.be.instanceof Building
    bgBlHouse.color.should.equal "blue"
    bgBlHouse.sqFt.should.equal 4000
    bgBlHouse.bedrooms.should.equal 5
    bgBlHouse.buildingMethod.should.be.a "function"
    bgBlHouse.houseMethod.should.be.a "function"

    famHouse = new BigBlueFamilyHouse()
    famHouse.should.be.instanceof House
    famHouse.should.be.instanceof Building
    famHouse.color.should.equal "blue"
    famHouse.sqFt.should.equal 4000
    famHouse.bedrooms.should.equal 6
    famHouse.buildingMethod.should.be.a "function"
    famHouse.houseMethod.should.be.a "function"

describe "unary", ->
  add3 = (a, b, c) ->
    b or= 0
    c or= 0
    a + b + c

  it "should only pass one argument to the function", ->
    parseIntUnary = unary parseInt
    ["1", "2", "3"].map( parseInt ).should.not.deep.equal [1, 2, 3]
    ["1", "2", "3"].map( parseIntUnary ).should.deep.equal [1, 2, 3]
    unary( add3 )( 1, 2, 3 ).should.equal 1

  it "should produce a function with length of 1", ->
    add3.length.should.equal 3
    unary( add3 ).length.should.equal 1

describe "binary", ->

describe "reverse", ->
  it "should reverse the order of arguments passed to a function", ->
    reverse( addFour )( "a", "b", "c", "d" ).should.equal "dcba"
  it "should preserve the length of the function", ->
    reverse( addFour ).length.should.equal addFour.length

describe "firstToLast", ->
  it "should shift all arguments forward one slot, with the first becoming last", ->
    firstToLast( addFour )( "a", "b", "c", "d" ).should.equal "bcda"
  it "should preserve the length of the function", ->
    firstToLast( addFour ).length.should.equal addFour.length

describe "lastToFirst", ->
  it "should shift all arguments back one slot, with the last becoming first", ->
    lastToFirst( addFour )( "a", "b", "c", "d" ).should.equal "dabc"
  it "should preserve the length of the function", ->
    lastToFirst( addFour ).length.should.equal addFour.length

