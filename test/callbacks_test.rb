# encoding: UTF-8

require File.expand_path("./helper", File.dirname(__FILE__))
require 'yaml'

setup do
  require 'test/test_classes'
end

# test do |params|
#   store = Store.new(:name => "Starbucks", :city  => "Chicago")
#   store.async { |resp|
#     puts resp.to_yaml
#   }.save
#   assert !store.new?
# end

test do |params|
  store = Store.new(:name => "Starbucks", :city  => "Chicago")
  store.after_save {|resp| puts resp.to_json }
  store.save
  assert !store.new?
end