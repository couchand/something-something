# unit tests

{should} = require './helper'

__ = require '../src'

describe 'aliases', ->
  describe 'collect', ->
    it 'is an alias for map', ->
      __.collect.should.equal __.map

  describe 'select', ->
    it 'is an alias for filter', ->
      __.select.should.equal __.filter

  describe 'some', ->
    it 'is an alias for any', ->
      __.some.should.equal __.any

  describe 'every', ->
    it 'is an alias for all', ->
      __.every.should.equal __.all

describe 'object', ->
  test = beforeEach -> test =
    foo: 1
    bar: 2
    baz: 3

  describe 'map', ->
    it 'callsback for each value', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb()

      __.map test, addVal, (error) ->
        should.not.exist error
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback for each key', (done) ->
      keys = []
      addKey = (key, val, cb) ->
        keys.push key
        cb()

      __.map test, addKey, (error) ->
        should.not.exist error
        keys.should.have.length 3
        keys.should.have.members ['foo', 'bar', 'baz']
        done()

    it 'callsback with the collection', (done) ->
      colls = []
      addColl = (key, val, coll, cb) ->
        colls.push coll
        cb()

      __.map test, addColl, (error) ->
        should.not.exist error
        colls.should.have.length 3
        colls[0].should.equal test
        colls[1].should.equal test
        colls[2].should.equal test
        done()

    it 'throws if iterator signature is wrong', ->
      (->
        __.map test, (->), ->
      ).should.throw /iterator/

    it 'ignores missing complete callback', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb()

      __.map test, addVal

      setImmediate ->
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'collects the results', (done) ->
      double = (val, cb) ->
        cb null, val * 2

      __.map test, double, (error, result) ->
        should.not.exist error
        result.foo.should.equal 2
        result.bar.should.equal 4
        result.baz.should.equal 6
        done()

    it 'callsback immediately on error', ->
      fail = (val, cb) ->
        cb 'oh no!'

      __.map test, fail, (error, result) ->
        should.exist error
        error.should.equal 'oh no!'
        should.not.exist result

  describe 'filter', ->
    it 'callsback for each value', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb()

      __.filter test, addVal, (error) ->
        should.not.exist error
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback for each key', (done) ->
      keys = []
      addKey = (key, val, cb) ->
        keys.push key
        cb()

      __.filter test, addKey, (error) ->
        should.not.exist error
        keys.should.have.length 3
        keys.should.have.members ['foo', 'bar', 'baz']
        done()

    it 'callsback with the collection', (done) ->
      colls = []
      addColl = (key, val, coll, cb) ->
        colls.push coll
        cb()

      __.filter test, addColl, (error) ->
        should.not.exist error
        colls.should.have.length 3
        colls[0].should.equal test
        colls[1].should.equal test
        colls[2].should.equal test
        done()

    it 'throws if iterator signature is wrong', ->
      (->
        __.filter test, (->), ->
      ).should.throw /iterator/

    it 'collects the results', (done) ->
      odd = (val, cb) ->
        cb null, val % 2

      __.filter test, odd, (error, result) ->
        should.not.exist error
        result.should.have.property 'foo'
        result.foo.should.equal 1
        result.should.not.have.property 'bar'
        result.should.have.property 'baz'
        result.baz.should.equal 3
        done()

    it 'callsback immediately on error', ->
      fail = (val, cb) ->
        cb 'oh no!'

      __.filter test, fail, (error, result) ->
        should.exist error
        error.should.equal 'oh no!'
        should.not.exist result

  describe 'any', ->
    it 'callsback for each value', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb null, no

      __.any test, addVal, (error) ->
        should.not.exist error
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback for each key', (done) ->
      keys = []
      addKey = (key, val, cb) ->
        keys.push key
        cb null, no

      __.any test, addKey, (error) ->
        should.not.exist error
        keys.should.have.length 3
        keys.should.have.members ['foo', 'bar', 'baz']
        done()

    it 'callsback with the collection', (done) ->
      colls = []
      addColl = (key, val, coll, cb) ->
        colls.push coll
        cb null, no

      __.any test, addColl, (error) ->
        should.not.exist error
        colls.should.have.length 3
        colls[0].should.equal test
        colls[1].should.equal test
        colls[2].should.equal test
        done()

    it 'throws if iterator signature is wrong', ->
      (->
        __.any test, (->), ->
      ).should.throw /iterator/

    it 'ignores missing complete callback', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb()

      __.any test, addVal

      setImmediate ->
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback immediately on error', ->
      fail = (val, cb) ->
        cb 'oh no!'

      __.any test, fail, (error, result) ->
        should.exist error
        error.should.equal 'oh no!'
        should.not.exist result

    it 'returns true if any is true', ->
      did = no
      one = (val, cb) ->
        return cb null, no if did
        did = yes
        cb null, yes

      __.any test, one, (error, result) ->
        should.not.exist error
        result.should.be.true

    it 'returns false if all are false', ->
      nope = (val, cb) ->
        cb null, no

      __.any test, nope, (error, result) ->
        should.not.exist error
        result.should.be.false

    it 'short-circuits', ->
      count = 0
      yep = (val, cb) ->
        count += 1
        cb null, yes

      __.any test, yep, (error, result) ->
        should.not.exist error
        count.should.equal 1

  describe 'all', ->
    it 'callsback for each value', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb null, yes

      __.all test, addVal, (error) ->
        should.not.exist error
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback for each key', (done) ->
      keys = []
      addKey = (key, val, cb) ->
        keys.push key
        cb null, yes

      __.all test, addKey, (error) ->
        should.not.exist error
        keys.should.have.length 3
        keys.should.have.members ['foo', 'bar', 'baz']
        done()

    it 'callsback with the collection', (done) ->
      colls = []
      addColl = (key, val, coll, cb) ->
        colls.push coll
        cb null, yes

      __.all test, addColl, (error) ->
        should.not.exist error
        colls.should.have.length 3
        colls[0].should.equal test
        colls[1].should.equal test
        colls[2].should.equal test
        done()

    it 'throws if iterator signature is wrong', ->
      (->
        __.all test, (->), ->
      ).should.throw /iterator/

    it 'ignores missing complete callback', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb()

      __.all test, addVal

      setImmediate ->
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback immediately on error', ->
      fail = (val, cb) ->
        cb 'oh no!'

      __.all test, fail, (error, result) ->
        should.exist error
        error.should.equal 'oh no!'
        should.not.exist result

    it 'returns false if any is false', ->
      did = no
      one = (val, cb) ->
        return cb null, no if did
        did = yes
        cb null, no

      __.all test, one, (error, result) ->
        should.not.exist error
        result.should.be.false

    it 'returns true if all are true', ->
      yep = (val, cb) ->
        cb null, yes

      __.all test, yep, (error, result) ->
        should.not.exist error
        result.should.be.true

    it 'short-circuits', ->
      count = 0
      nope = (val, cb) ->
        count += 1
        cb null, no

      __.all test, nope, (error, result) ->
        should.not.exist error
        count.should.equal 1

  describe 'reduce', ->
    it 'something'

describe 'array', ->
  test = beforeEach -> test = [
    1
    2
    3
  ]

  describe 'map', ->
    it 'callsback for each value', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb()

      __.map test, addVal, (error) ->
        should.not.exist error
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback for each key', (done) ->
      keys = []
      addKey = (key, val, cb) ->
        keys.push key
        cb()

      __.map test, addKey, (error) ->
        should.not.exist error
        keys.should.have.length 3
        keys.should.have.members [0, 1, 2]
        done()

    it 'callsback with the collection', (done) ->
      colls = []
      addColl = (key, val, coll, cb) ->
        colls.push coll
        cb()

      __.map test, addColl, (error) ->
        should.not.exist error
        colls.should.have.length 3
        colls[0].should.equal test
        colls[1].should.equal test
        colls[2].should.equal test
        done()

    it 'throws if iterator signature is wrong', ->
      (->
        __.map test, (->), ->
      ).should.throw /iterator/

    it 'collects the results', (done) ->
      double = (val, cb) ->
        cb null, val * 2

      __.map test, double, (error, result) ->
        should.not.exist error
        result.should.have.length 3
        result[0].should.equal 2
        result[1].should.equal 4
        result[2].should.equal 6
        done()

    it 'callsback immediately on error', ->
      fail = (val, cb) ->
        cb 'oh no!'

      __.map test, fail, (error, result) ->
        should.exist error
        error.should.equal 'oh no!'
        should.not.exist result

  describe 'filter', ->
    it 'callsback for each value', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb()

      __.filter test, addVal, (error) ->
        should.not.exist error
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback for each key', (done) ->
      keys = []
      addKey = (key, val, cb) ->
        keys.push key
        cb()

      __.filter test, addKey, (error) ->
        should.not.exist error
        keys.should.have.length 3
        keys.should.have.members [0, 1, 2]
        done()

    it 'callsback with the collection', (done) ->
      colls = []
      addColl = (key, val, coll, cb) ->
        colls.push coll
        cb()

      __.filter test, addColl, (error) ->
        should.not.exist error
        colls.should.have.length 3
        colls[0].should.equal test
        colls[1].should.equal test
        colls[2].should.equal test
        done()

    it 'throws if iterator signature is wrong', ->
      (->
        __.filter test, (->), ->
      ).should.throw /iterator/

    it 'collects the results', (done) ->
      odd = (val, cb) ->
        cb null, val % 2

      __.filter test, odd, (error, result) ->
        should.not.exist error
        result.should.have.length 2
        result.should.have.members [1, 3]
        done()

    it 'callsback immediately on error', ->
      fail = (val, cb) ->
        cb 'oh no!'

      __.filter test, fail, (error, result) ->
        should.exist error
        error.should.equal 'oh no!'
        should.not.exist result

  describe 'any', ->
    it 'callsback for each value', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb null, no

      __.any test, addVal, (error) ->
        should.not.exist error
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback for each key', (done) ->
      keys = []
      addKey = (key, val, cb) ->
        keys.push key
        cb null, no

      __.any test, addKey, (error) ->
        should.not.exist error
        keys.should.have.length 3
        keys.should.have.members [0, 1, 2]
        done()

    it 'callsback with the collection', (done) ->
      colls = []
      addColl = (key, val, coll, cb) ->
        colls.push coll
        cb null, no

      __.any test, addColl, (error) ->
        should.not.exist error
        colls.should.have.length 3
        colls[0].should.equal test
        colls[1].should.equal test
        colls[2].should.equal test
        done()

    it 'throws if iterator signature is wrong', ->
      (->
        __.any test, (->), ->
      ).should.throw /iterator/

    it 'ignores missing complete callback', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb()

      __.any test, addVal

      setImmediate ->
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback immediately on error', ->
      fail = (val, cb) ->
        cb 'oh no!'

      __.any test, fail, (error, result) ->
        should.exist error
        error.should.equal 'oh no!'
        should.not.exist result

    it 'returns true if any is true', ->
      did = no
      one = (val, cb) ->
        return cb null, no if did
        did = yes
        cb null, yes

      __.any test, one, (error, result) ->
        should.not.exist error
        result.should.be.true

    it 'returns false if all are false', ->
      nope = (val, cb) ->
        cb null, no

      __.any test, nope, (error, result) ->
        should.not.exist error
        result.should.be.false

    it 'short-circuits', ->
      count = 0
      yep = (val, cb) ->
        count += 1
        cb null, yes

      __.any test, yep, (error, result) ->
        should.not.exist error
        count.should.equal 1

  describe 'all', ->
    it 'callsback for each value', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb null, yes

      __.all test, addVal, (error) ->
        should.not.exist error
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback for each key', (done) ->
      keys = []
      addKey = (key, val, cb) ->
        keys.push key
        cb null, yes

      __.all test, addKey, (error) ->
        should.not.exist error
        keys.should.have.length 3
        keys.should.have.members [0, 1, 2]
        done()

    it 'callsback with the collection', (done) ->
      colls = []
      addColl = (key, val, coll, cb) ->
        colls.push coll
        cb null, yes

      __.all test, addColl, (error) ->
        should.not.exist error
        colls.should.have.length 3
        colls[0].should.equal test
        colls[1].should.equal test
        colls[2].should.equal test
        done()

    it 'throws if iterator signature is wrong', ->
      (->
        __.all test, (->), ->
      ).should.throw /iterator/

    it 'ignores missing complete callback', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb()

      __.all test, addVal

      setImmediate ->
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback immediately on error', ->
      fail = (val, cb) ->
        cb 'oh no!'

      __.all test, fail, (error, result) ->
        should.exist error
        error.should.equal 'oh no!'
        should.not.exist result

    it 'returns false if any is false', ->
      did = no
      one = (val, cb) ->
        return cb null, no if did
        did = yes
        cb null, no

      __.all test, one, (error, result) ->
        should.not.exist error
        result.should.be.false

    it 'returns true if all are true', ->
      yep = (val, cb) ->
        cb null, yes

      __.all test, yep, (error, result) ->
        should.not.exist error
        result.should.be.true

    it 'short-circuits', ->
      count = 0
      nope = (val, cb) ->
        count += 1
        cb null, no

      __.all test, nope, (error, result) ->
        should.not.exist error
        count.should.equal 1

  describe 'reduce', ->
    it 'something'
