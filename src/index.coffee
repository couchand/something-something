# async collection utilities

isArray = require 'isarray'

id = (k, v, c) -> v
collect = (k, v, c) -> if v then c[k]

map = (collection, iterator, complete, convert=id) ->
  keys = if isArray collection
    [0...collection.length]
  else
    Object.keys(collection)
  length = keys.length
  count = 0
  accumulator = {}

  cb = (key) ->
    if complete?
      (value) ->
        accumulator[key] = convert key, value, collection
        count += 1
        complete accumulator if complete and count is length
    else
      ->

  iterate = switch iterator.length
    when 2 then (key, value) ->
      iterator value, cb(key)
    when 3 then (key, value) ->
      iterator key, value, cb(key)
    when 4 then (key, value) ->
      iterator key, value, collection, cb(key)
    else throw new Error 'Ambiguous iterator signature'

  (iterate key, collection[key] for key in keys)

filter = (collection, iterator, complete) ->
  map collection, iterator, complete, collect

module.exports = {map, filter}
