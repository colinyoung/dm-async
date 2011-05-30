require "dm-core"

$LOAD_PATH.unshift ::File.expand_path(::File.dirname(__FILE__) + '/../lib')
LOGDIR = File.expand_path('log', File.dirname(__FILE__) + "/../")

require 'active_support'
require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/numeric/time'

require 'dm-core'

require 'dm-asynchronous/callback_blocks'
require 'dm-asynchronous/remote_handlers'
require 'dm-asynchronous/adapters/adapters'

module DataMapper
	module Asynchronous
    include CallbackBlocks
    
    mattr_accessor :backend

    def self.included(base)
      @@base_module = base
      base.extend(ClassMethods)
      base.extend(CallbackBlocks::ClassMethods)
    end
    
    def self.backend=(b)
      ClassMethods.backend = b
    end

    module ClassMethods
      
      mattr_accessor :backend
      
      def async_adapter
        const_name = "Adapters::" + "#{backend}".camelize
        const = class_eval "#{const_name}"
        return const unless !const
        Adapters::Default
      end
      
    end

	end
end