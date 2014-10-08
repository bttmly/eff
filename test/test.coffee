Function::bind or= require "function-bind"
chai = require "chai"
should = chai.should()
{ utils, Assertion } = chai

###
utils.addMethod(chai.Assertion.prototype, 'foo', function (str) {
  var obj = utils.flag(this, 'object');
  new chai.Assertion(obj).to.be.equal(str);
});
###

eff = require "../src/index.coffee"

{ curry,
  partial,
  partialConstructor,
  flip,
  swap,
  reverse,
  firstToLast,
  lastToFirst,
  unary,
  binary,
  rotate,
  arity,
  sequence,
  compose
  nAry } = eff

isEff = do ->
  effn = eff ->
  ( fn ) ->
    for key, val of effn
      return false if fn[key] isnt val
    true

addTwo = (a, b) ->
  a + b

addThree = (a, b, c) ->
  a + b + c

addFour = (a, b, c, d) ->
  a + b + c + d

addAll = (a, b, c, d) ->
  t = 0
  t += n for n in arguments
  t

map = ( arr, cb ) ->
  cb item, i, arr for item, i in arr

filter = ( arr, cb ) ->
  item for item, i in arr when cb item, i arr

describe "eff()", ->
  addAll = undefined
  dec = undefined

  beforeEach ->
    addAll = (a, b, c, d) ->
      t = arguments[0]
      t += n for n, i in arguments when i > 0
      t
    dec = eff addAll

  it "should have a working curry method", ->
    dec.curry()(1).should.be.a "function"
    dec.curry()(1)(2).should.be.a "function"
    dec.curry()(1)(2)(3).should.be.a "function"
    dec.curry()(1)(2)(3)(4).should.equal 10
    isEff( dec.curry() ).should.equal true

  it "should have a working partial method", ->
    dec.partial(1, 2).should.be.a "function"
    dec.partial(1, 2)(3, 4).should.equal 10
    dec.partial(1, 2)(3, 4, 5).should.equal 15
    isEff( dec.partial(1) ).should.equal true

  it "should have a working flip method", ->
    dec.flip()("a", "b").should.equal "ba"
    dec.flip()("a", "b", "c").should.equal "bac"
    isEff( dec.flip() ).should.equal true

  it "should have a working swap method", ->
    dec.swap(1, 2)('a', 'b', 'c', 'd').should.equal 'acbd'
    isEff( dec.swap(1, 2) ).should.equal true

  it 'should have a working reverse method', ->
    dec.reverse()('a', 'b', 'c', 'd').should.equal 'dcba'
    isEff( dec.reverse() ).should.equal true

  it 'should have a working firstToLast method', ->
    dec.firstToLast()('a', 'b', 'c', 'd').should.equal 'bcda'
    isEff( dec.firstToLast() ).should.equal true

  it 'should have a working lastToFirst method', ->
    dec.lastToFirst()('a', 'b', 'c', 'd').should.equal 'dabc'
    isEff( dec.lastToFirst() ).should.equal true

  it 'should have a working unary method', ->
    dec.unary()(1, 2).should.equal 1
    isEff( dec.unary() ).should.equal true

  it 'should have a working binary method', ->
    dec.binary()(1, 2, 3).should.equal 3
    isEff( dec.binary() ).should.equal true


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
    isEff( curry( addFour, 1, 2, 3, 4 ) ).should.equal true
    curry( addFour, 1, 2, 3, 4 )().should.equal 10
    curry( addFour, 1, 2, 3, 4, 5 ).should.be.a "function"
    isEff( curry( addFour, 1, 2, 3, 4, 5 ) ).should.equal true
    curry( addFour, 1, 2, 3, 4, 5 )().should.equal 10

  it "should return functions which continue to return functions until their arguments are filled", ->
    curryAddFour.should.be.a "function"
    isEff( curryAddFour ).should.equal true

    curryAddFour_1.should.be.a "function"
    isEff( curryAddFour_1 ).should.equal true

    curryAddFour_1_2.should.be.a "function"
    isEff( curryAddFour_1_2 ).should.equal true

    curryAddFour_1_2_3.should.be.a "function"
    isEff( curryAddFour_1_2_3 ).should.equal true

    curryAddFour_1_2_5.should.be.a "function"
    isEff( curryAddFour_1_2_5 ).should.equal true

    ten = curryAddFour_1_2_3(4)
    fourteen = curry(addFour)(2)(3)(4)(5)
    fifteen = curryAddFour_1_2_5(7)
    ten.should.equal 10
    fourteen.should.equal 14
    fifteen.should.equal 15

  it "should return functions with length equal to remaining unfilled arguments", ->
    curryAddFour.length.should.equal 4
    curryAddFour_1.length.should.equal 3
    curryAddFour_1_2.length.should.equal 2
    curryAddFour_1_2_3.length.should.equal 1
    curryAddFour_1_2_3_4 = curry addFour, 1, 2, 3, 4
    curryAddFour_1_2_3_4.length.should.equal 0
    curryAddFour_1_2_3_4().should.equal 10

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

describe "partial", ->
  it "should partially apply arguments to a function", ->
    partial( addFour, 1 )( 2, 3, 4 ).should.equal 10
    partial( addFour, 1, 2 )( 3, 4 ).should.equal 10

  it "should return a partially applied function with length equal to number of additional expected arguments", ->
    partial( addFour, 1 ).length.should.equal 3
    partial( addFour, 1, 2 ).length.should.equal 2
    partial( addFour, 1, 2, 3 ).length.should.equal 1
    partial( addFour, 1, 2, 3, 4 ).length.should.equal 0
    partial( addFour, 1, 2, 3, 4, 5 ).length.should.equal 0

  it "should support repeated partial application", ->
    partialAddFour_1_2 = partial addFour, 1, 2
    partialAddFour_1_2_3_4 = partial partialAddFour_1_2, 3, 4
    partialAddFour_1_2_3_4().should.equal 10
    partialAddFour_1_2_3_4( "xyz" ).should.equal 10

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

  BlueHouse = partialConstructor( House, "blue" )
  BigBlueHouse = partialConstructor( BlueHouse, 4000 )
  BigBlueFamilyHouse = partialConstructor( BigBlueHouse, 6 )

  it "should work properly called on a constructor once", ->
    whtBldg = new WhiteBuilding( 3000 )
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
    blHouse = new BlueHouse( 1500, 3 )
    blHouse.should.be.instanceof House
    blHouse.should.be.instanceof Building
    blHouse.color.should.equal "blue"
    blHouse.sqFt.should.equal 1500
    blHouse.bedrooms.should.equal 3
    blHouse.buildingMethod.should.be.a "function"
    blHouse.houseMethod.should.be.a "function"

  it "should support repeated partial application for subclassing", ->
    bgBlHouse = new BigBlueHouse( 5 )
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
  add3OrLess = (a, b, c) ->
    b or= 0
    c or= 0
    a + b + c

  it "should only pass one argument to the function", ->
    parseIntUnary = unary parseInt
    ["1", "2", "3"].map( parseInt ).should.not.deep.equal [1, 2, 3]
    ["1", "2", "3"].map( parseIntUnary ).should.deep.equal [1, 2, 3]
    unary( add3OrLess )( 1, 2, 3 ).should.equal 1

  it "should produce a function with length of 1", ->
    add3OrLess.length.should.equal 3
    unary( add3OrLess ).length.should.equal 1

describe "binary", ->
  add3OrLess = (a, b, c) ->
    b or= 0
    c or= 0
    a + b + c

  it "should only pass one argument to the function", ->
    binary( add3OrLess )( 1, 2, 3 ).should.equal 3

  it "should produce a function with length of 1", ->
    add3OrLess.length.should.equal 3
    binary( add3OrLess ).length.should.equal 2

  it "should produce an eff'd function", ->


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

describe "rotate", ->
  it "should rotate front arguments to the back", ->
    rotate( addFour, 2 )( "a", "b", "c", "d", "e" ).should.equal "cdea"
  it "should rotate back arguments to the front", ->
    rotate( addFour, 2, -1 )( "a", "b", "c", "d", "e" ).should.equal "deab"

describe "arity", ->
  it "should return a function with length 'n' but pass through all arguments", ->
    addArity2 = arity addAll, 2
    addArity2.length.should.equal 2
    addArity2( 1, 2 ).should.equal 3
    addArity2( 1, 2, 3 ).should.equal 6

describe "nAry", ->
  it "should return a function with length 'n' and pass through only first 'n' arguments", ->
    addNAry2 = nAry addAll, 2
    addNAry2.length.should.equal 2
    addNAry2( 1, 2 ).should.equal 3
    addNAry2( 1, 2, 3 ).should.equal 3

describe "wrap", ->
  xit "should wrap a function and apply arguments", ->
    wrapped = wrap addAll, ( func, a, b ) ->
      "total is #{ func(a, b) }"
    wrapped(10, 200).should.equal "total is 30"

describe "compose", ->
  xit "should compose functions", ->
    times2 = ( n ) -> n / 2
    plus4 = ( n ) -> n + 4
    div8 = ( n ) -> n / 8
    comp = compose div8, times2, plus4
    comp( 4 ).should.equal 2

describe "sequence", ->
  xit "should sequence functions", ->
    times2 = ( n ) -> n / 2
    plus4 = ( n ) -> n + 4
    div8 = ( n ) -> n / 8
    seq = sequence div8, times2, plus4
    seq( 4 ).should.equal 5

