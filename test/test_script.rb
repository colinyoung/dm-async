require 'rubygems'
require 'lib/dm-asynchronous'
require 'dm-redis-adapter'
require 'test/test_classes'
require 'json'

puts "Testing Redis models..."

DataMapper.setup(:default, {:adapter  => "redis"})
DataMapper::Asynchronous.backend = :threading

RedisStore.all

# store = RedisStore.new
# store.city = "Chicago"
# # store.after {|params|
# #   puts "This code was executed after this object was saved.\nThe remote set returned: #{params.to_json}"
# # }.save

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