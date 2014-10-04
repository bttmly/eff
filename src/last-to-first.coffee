rotate = require "./rotate"

module.exports = lastToFirst = ( fn ) -> rotate fn, 1, -1
