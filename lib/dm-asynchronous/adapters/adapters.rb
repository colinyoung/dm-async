require 'dm-asynchronous/adapters/default/default'
require 'dm-asynchronous/adapters/delayed_job/delayed_job'
require 'dm-asynchronous/adapters/threading/threading'
# require 'asynchronous/adapters/resque/resque' # Removed until Resque can execute blocks

module DataMapper
  module Asynchronous
    module Adapters
    end
  end
end