require 'active_support'
require 'active_support/core_ext/numeric/time'
require 'system_timer'

require 'ohm/contrib'

require File.join(File.dirname(__FILE__), 'block')
require File.join(File.dirname(__FILE__), 'callback_method_definitions')

module Ohm
  module Asynchronous
    class Model < Ohm::Model
      
      include Ohm::Callbacks # From Ohm-Contrib
      include CallbackMethodDefinitions
      extend Block
      
      def save(*args)
        puts "Save"
        super
      end
      
      def later(&block)
        unless block_given? 
          puts "Warning: No block given in 'later()'"
          return self 
        end
        
        id = ActiveSupport::SecureRandom.hex(6)
        self.class.add_block(id, block)
        Thread.new do
          Thread.current[:id] = id
        end
        
        self
      end
      
    end
  end
end
