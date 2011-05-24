require 'rubygems'
require 'lib/ohm_async'
require 'test/test_classes'
require 'json'

Ohm.flush

store = Store.new
store.city = "Chicago"
store.after {|params|
  puts "This code was executed after this object was saved.\nThe remote set returned: #{params.to_json}"
}.save

# store = Store.new
# store.city = "Chicago"
# store.save
# store.after {|params|
#   puts "This code was executed after this object was deleted.\nThe remote set returned: #{params.to_json}"
# }
# store.delete

# 
# store = Store.new
# store.city = "Chicago"
# store.after_save {|params|
#   puts "This code was later'd...\nParams: #{params.to_json}"
# }
# store.save

# store = Store.all