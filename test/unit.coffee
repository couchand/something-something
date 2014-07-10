# unit tests

require './helper'

_ = require '../src'

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

      _.map test, addVal, ->
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback for each key', (done) ->
      keys = []
      addKey = (key, val, cb) ->
        keys.push key
        cb()

      _.map test, addKey, ->
        keys.should.have.length 3
        keys.should.have.members ['foo', 'bar', 'baz']
        done()

    it 'callsback with the collection', (done) ->
      colls = []
      addColl = (key, val, coll, cb) ->
        colls.push coll
        cb()

      _.map test, addColl, ->
        colls.should.have.length 3
        colls[0].should.equal test
        colls[1].should.equal test
        colls[2].should.equal test
        done()

    it 'throws if iterator signature is wrong', ->
      (->
        _.map test, (->), ->
      ).should.throw /iterator/

    it 'ignores missing complete callback', (done) ->
      vals = []
      addVal = (val, cb) ->
        vals.push val
        cb()

      _.map test, addVal

      setImmediate ->
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'collects the results', (done) ->
      double = (val, cb) ->
        cb val * 2

      _.map test, double, (result) ->
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

      _.filter test, addVal, ->
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback for each key', (done) ->
      keys = []
      addKey = (key, val, cb) ->
        keys.push key
        cb()

      _.filter test, addKey, ->
        keys.should.have.length 3
        keys.should.have.members ['foo', 'bar', 'baz']
        done()

    it 'callsback with the collection', (done) ->
      colls = []
      addColl = (key, val, coll, cb) ->
        colls.push coll
        cb()

      _.filter test, addColl, ->
        colls.should.have.length 3
        colls[0].should.equal test
        colls[1].should.equal test
        colls[2].should.equal test
        done()

    it 'throws if iterator signature is wrong', ->
      (->
        _.filter test, (->), ->
      ).should.throw /iterator/

    it 'collects the results', (done) ->
      odd = (val, cb) ->
        cb val % 2

      _.filter test, odd, (result) ->
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

      _.map test, addVal, ->
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback for each key', (done) ->
      keys = []
      addKey = (key, val, cb) ->
        keys.push key
        cb()

      _.map test, addKey, ->
        keys.should.have.length 3
        keys.should.have.members [0, 1, 2]
        done()

    it 'callsback with the collection', (done) ->
      colls = []
      addColl = (key, val, coll, cb) ->
        colls.push coll
        cb()

      _.map test, addColl, ->
        colls.should.have.length 3
        colls[0].should.equal test
        colls[1].should.equal test
        colls[2].should.equal test
        done()

    it 'throws if iterator signature is wrong', ->
      (->
        _.map test, (->), ->
      ).should.throw /iterator/

    it 'collects the results', (done) ->
      double = (val, cb) ->
        cb val * 2

      _.map test, double, (result) ->
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

      _.filter test, addVal, ->
        vals.should.have.length 3
        vals.should.have.members [1, 2, 3]
        done()

    it 'callsback for each key', (done) ->
      keys = []
      addKey = (key, val, cb) ->
        keys.push key
        cb()

      _.filter test, addKey, ->
        keys.should.have.length 3
        keys.should.have.members [0, 1, 2]
        done()

    it 'callsback with the collection', (done) ->
      colls = []
      addColl = (key, val, coll, cb) ->
        colls.push coll
        cb()

      _.filter test, addColl, ->
        colls.should.have.length 3
        colls[0].should.equal test
        colls[1].should.equal test
        colls[2].should.equal test
        done()

    it 'throws if iterator signature is wrong', ->
      (->
        _.filter test, (->), ->
      ).should.throw /iterator/

    it 'collects the results', (done) ->
      odd = (val, cb) ->
        cb val % 2

      _.filter test, odd, (result) ->
        result.should.have.length 2
        result.should.have.members [1, 3]
        done()

  describe 'any', ->
    it 'something'

  describe 'all', ->
    it 'something'

  describe 'reduce', ->
    it 'something'
