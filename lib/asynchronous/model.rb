require 'active_support'
require 'active_support/core_ext/numeric/time'
require 'system_timer'

require 'ohm/contrib'

require File.join(File.dirname(__FILE__), 'callback_blocks')

module Ohm
  module Asynchronous
    class Model < Ohm::Model
      
      include Ohm::Callbacks # From Ohm-Contrib
      include CallbackBlocks
      
    end
  end
end
