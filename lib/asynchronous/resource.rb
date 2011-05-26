require 'active_support'
require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/numeric/time'

require 'dm-core'

require 'asynchronous/callback_blocks'
require 'asynchronous/adapters/adapters'

module DataMapper
	module Asynchronous
		class Resource < DataMapper::Resource
		  
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
