require 'active_support'
require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/numeric/time'

require 'ohm/contrib'

require 'asynchronous/callback_blocks'
require 'asynchronous/adapters/adapters'

module Ohm
	module Asynchronous
		class Model < Ohm::Model
		  
			include Ohm::Callbacks # From Ohm-Contrib
			include CallbackBlocks
			
			cattr_accessor :backend

      def self.adapter
        const_name = "Adapters::" + "#{self.backend}".camelize
        const = class_eval "#{const_name}"
        return const unless !const
        Adapters::Default
      end
									
		end
	end
end
