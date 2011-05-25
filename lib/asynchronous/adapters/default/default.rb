module Ohm
  module Asynchronous
    module Adapters
      
      class Default
            
        def self.execute_block_later(*args)
          raise "[Ohm::Asynchronous] WARNING: No backend chosen for ohm_async. Jobs will not be executed asynchronously."
        end
      
      end
        
    end
  end
end