rotate = require "./rotate.coffee"

module.exports = lastToFirst = ( fn ) -> rotate fn, 1, 1
