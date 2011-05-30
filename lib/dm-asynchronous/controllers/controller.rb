if defined?(Rails)

  module DataMapper
    module Asynchronous
      class Controller < ApplicationController
      
        def render(*args)
          model_var = args.shift
          model_var.class.finish
          super args
        end
        
      end
    end
  end

end