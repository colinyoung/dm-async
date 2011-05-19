# encoding: UTF-8

require File.expand_path("./helper", File.dirname(__FILE__))

setup do
  require 'test_classes'
end

test do |params|
  store = Store.new(:name => "Starbucks", :city  => "Chicago")
  store.later { |resp|
    puts "#{resp}"
  }.save
  assert !store.new?
end

test do |params|
  store = Store.new(:name => "Starbucks", :city  => "Chicago")
  store.later.save
  assert !store.new?
end