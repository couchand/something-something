# async collection utilities

isArray = require 'isarray'

id = (k, v, c) -> v
collect = (k, v, c) -> if v then c[k]

accumulator = (collection) ->
  if isArray collection then [] else {}

each = (collection, iterator, complete, convert) ->
  keys = if isArray collection
    [0...collection.length]
  else
    Object.keys collection

  length = keys.length
  count = 0

  cb = (key) -> (value) ->
    convert key, value
    count += 1
    complete() if complete and count is length

  iterate = switch iterator.length
    when 2 then (key, value) ->
      iterator value, cb(key)
    when 3 then (key, value) ->
      iterator key, value, cb(key)
    when 4 then (key, value) ->
      iterator key, value, collection, cb(key)
    else throw new Error 'Ambiguous iterator signature'

  (iterate key, collection[key] for key in keys)

map = (collection, iterator, complete) ->
  result = accumulator collection
  each collection, iterator,
    -> complete result if complete
    (key, value) ->
      result[key] = value

filter = (collection, iterator, complete) ->
  result = accumulator collection
  each collection, iterator,
    -> complete result if complete
    (key, value) ->
      if isArray collection
        result.push collection[key] if value
      else
        result[key] = collection[key] if value

module.exports = {map, filter}
