if defined?(Rails)

  module DataMapper::Asynchronous
    def self.rails
      
      module_eval <<-"end_eval"
        class Controller < ::ApplicationController
  
          def render(*args)
            model_var = args.shift
            model_var.class.finish
            super args
          end
    
        end
      end_eval
      
    end
  
  end

end