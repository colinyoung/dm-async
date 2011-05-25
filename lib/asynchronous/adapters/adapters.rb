require 'asynchronous/adapters/default/default'
require 'asynchronous/adapters/delayed_job/delayed_job'
require 'asynchronous/adapters/threading/threading'
# require 'asynchronous/adapters/resque/resque' # Removed until Resque can execute blocks

module Ohm
  module Asynchronous
    module Adapters
    end
  end
end