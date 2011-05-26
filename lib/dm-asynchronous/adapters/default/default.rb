module DataMapper
  module Asynchronous
    module Adapters
      
      class Default
            
        def self.execute_block_later(*args)
          raise "[DataMapper::Asynchronous] WARNING: No backend chosen for dm-async. Jobs will not be executed asynchronously."
        end
      
      end
        
    end
  end
end