# async collection utilities

# isArray = require 'isarray'
isArray = Array.isArray or (arr) ->
  Object.prototype.toString.call(arr) is '[object Array]'

id = (k, v, c) -> v
collect = (k, v, c) -> if v then c[k]

accumulator = (collection) ->
  if isArray collection then [] else {}

each = (collection, iterator, complete, convert) ->
  keys = if isArray collection
    [0...collection.length]
  else
    Object.keys collection

  failed = no
  fail = (error) ->
    failed = yes
    complete error

  length = keys.length
  count = 0

  cb = (key) -> (error, value) ->
    return if failed
    return fail error if error

    convert key, value
    count += 1
    complete() if count is length

  iterate = switch iterator.length
    when 2 then (key, value) ->
      iterator value, cb(key)
    when 3 then (key, value) ->
      iterator key, value, cb(key)
    when 4 then (key, value) ->
      iterator key, value, collection, cb(key)
    else throw new Error 'Ambiguous iterator signature'

  (iterate key, collection[key] for key in keys)

handle = (complete, result) ->
  return (->) unless complete?
  (error) -> if error then complete(error) else complete(null, result)

map = (collection, iterator, complete) ->
  result = accumulator collection
  cb = handle complete, result

  convert = (key, value) ->
    result[key] = value

  each collection, iterator, cb, convert

filter = (collection, iterator, complete) ->
  result = accumulator collection
  cb = handle complete, result

  convert = (key, value) ->
    if isArray collection
      result.push collection[key] if value
    else
      result[key] = collection[key] if value

  each collection, iterator, cb, convert

module.exports = {
  map
  collect: map
  filter
  select: filter
}
