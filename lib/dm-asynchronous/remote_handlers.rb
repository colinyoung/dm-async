class Module
  def submodules
    constants.collect {|const_name| const_get(const_name)}.select {|const| const.class == Module}
  end
end

module DataMapper
  module Asynchronous
    module RemoteHandlers
      
      def self.included(base)
        begin
          base.extend(base.submodules.first)
        rescue
          raise "Your handlers didn't follow the correct format -- See the docs for more."
        end
      end
      
      # Override this method with your own implementation in a submodule.
      # 
      # @return [Array] an array of objects now that the remote action has completed.
      def remote_after_save
        []
      end
      
      # Override this method with your own implementation in a submodule.
      # 
      # @return [Array] an array of objects now that the remote action has completed.
      def remote_after_create
        []
      end
      
      # Override this method with your own implementation in a submodule.
      # 
      # @return [Array] an array of objects now that the remote action has completed.
      def remote_after_update
        []
      end
      
      # Override this method with your own implementation in a submodule.
      # 
      # @return [Array] an array of objects now that the remote action has completed.
      def remote_after_delete
        []
      end
      
      # Override this method with your own implementation in a submodule.
      # 
      # @return [Array] an array of objects now that the remote action has completed.
      def remote_after_validate
        []
      end
      
    end
  end
end