// Generated by CoffeeScript 1.8.0
(function() {
  var lastToFirst, rotate;

  rotate = require("./rotate");

  module.exports = lastToFirst = function(fn) {
    return rotate(fn, 1, 1);
  };

}).call(this);