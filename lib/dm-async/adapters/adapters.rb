require 'dm-async/adapters/default/default'
require 'dm-async/adapters/delayed_job/delayed_job'
require 'dm-async/adapters/threading/threading'
# require 'asynchronous/adapters/resque/resque' # Removed until Resque can execute blocks

module DataMapper
  module Asynchronous
    module Adapters
    end
  end
end