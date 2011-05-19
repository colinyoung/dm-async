require 'rubygems'
require 'lib/ohm_async'
require 'test/test_classes'

store = Store.new
store.city = "Chicago"
store.later {|params|
  puts params
}.save