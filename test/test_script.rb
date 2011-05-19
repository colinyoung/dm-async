require 'rubygems'
require 'lib/ohm_async'
require 'test/test_classes'
require 'json'

Ohm.flush

store = Store.new
store.city = "Chicago"
store.async do |params|
  puts "This code was later'd...\nParams: #{params.to_json}"
end
store.save

store = Store.new
store.city = "Chicago"
store.after_save {|params|
  puts "This code was later'd...\nParams: #{params.to_json}"
}
store.save