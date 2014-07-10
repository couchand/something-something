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

  describe 'any', ->
    it 'something'

  describe 'all', ->
    it 'something'

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

  describe 'any', ->
    it 'something'

  describe 'all', ->
    it 'something'

  describe 'reduce', ->
    it 'something'
