module Ohm
  module Asynchronous
    class RemoteHandlers
      # Override this method with your own implementation in a subclass.
      # 
      # @return [Array] an array of objects now that the remote action has completed.
      def remote_after_save
        []
      end
      
      # Override this method with your own implementation in a subclass.
      # 
      # @return [Array] an array of objects now that the remote action has completed.
      def remote_after_create
        []
      end
      
      # Override this method with your own implementation in a subclass.
      # 
      # @return [Array] an array of objects now that the remote action has completed.
      def remote_after_update
        []
      end
      
      # Override this method with your own implementation in a subclass.
      # 
      # @return [Array] an array of objects now that the remote action has completed.
      def remote_after_delete
        []
      end
      
      # Override this method with your own implementation in a subclass.
      # 
      # @return [Array] an array of objects now that the remote action has completed.
      def remote_after_validate
        []
      end
      
    end
  end
end