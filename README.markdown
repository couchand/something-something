something something
===================

*go crazy?  don't mind if i do...*

a little asynchronous functional programming library.

  * why?
  * how?
  * what?

why?
----

There are plenty of collections libraries out there (think
[underscore][0], [lodash][1], etc) and plenty of asynchronous ones
([async][2] comes to mind), but none of them seem to support
asynchronous mapping over plain old JavaScript objects.  So I wrote
this for that use-case, and while I was at it I just made it general.

how?
----

Use the package manager or your choice to install.  We support

```sh
# npm
npm install --save something-something

# component
component install couchand/something-something

# bower
bower install something-something
```

Require it in your project and start asynchronizing.

```coffeescript
_ = require 'something-something'

double = (value, cb) -> cb value * 2
ba_s = (key, value, cb) -> cb /ba./.test key

original =
  foo: 1
  bar: 2
  baz: 3

_.map original, double, (doubled) ->
  _.filter doubled, ba_s, (result) ->
    assert Object.keys(result).length is 2
    assert result.bar is 4
    assert result.baz is 6
```

Simple, right?

what?
-----

The standard functional collections methods are here.

  * [map](#map)
  * [reduce](#reduce)
  * [filter](#filter)
  * [any](#any)
  * [all](#all)

All methods work equally well for arrays and objects.

### map ###

```
map(collection, iterator, [complete])

collection = Array
           | Object
iterator = (value, cb) -> result
         | (key, value, cb) -> result
         | (key, value, collection, cb) -> result
complete = (results) ->
```

Standard `map` function, known in some circles as `collect`.  The
iterator function is called for each element in the collection.  Its
behavior is guessed from the airity of the function, so don't try any
fancy business with `arguments` here.

The complete callback is called with the `results` collection once
every iteration is complete.

### reduce ###

Not yet implemented.  Docs to come.

### filter ###

```
filter(collection, predicate, [complete])

collection = Array
           | Object
predicate = (value, cb) -> Boolean
         | (key, value, cb) -> Boolean
         | (key, value, collection, cb) -> Boolean
complete = (results) ->
```

Standard `filter` function, also known as `select`.  The predicate
is called for each element in the collection.  Again its behavior is
assumed based on the airity.  The result is coerced to a Boolean.

The complete callback is called with the filtered `results` once
every predicate is complete.

### any ###

Not yet implemented.  Docs to come.

### all ###

Not yet implemented.  Docs to come.

##### ╭╮☲☲☲╭╮ #####

[0]: http://underscorejs.org
[1]: http://lodash.com
[2]: https://github.com/caolan/async