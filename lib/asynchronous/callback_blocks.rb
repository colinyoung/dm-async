module Ohm
  module Asynchronous
    module CallbackBlocks
      
      attr_accessor :blocks
      attr_accessor :temp_block
      
      # @method after_create(&block)
      # Add a block to be executed after an object is created.
      # 
      # @return void
      def after_create(&block); end
      
      # @method after_save(&block)
      # Add a block to be executed after an object is saved.  This is the default for the `after` method.
      # 
      # @return void
      def after_save(&block); end      
      
      # @method after_update(&block)
      # Add a block to be executed after an object is updated.
      # 
      # @return void
      def after_update(&block); end      
      
      # @method after_delete(&block)
      # Add a block to be executed after an object is deleted.
      # 
      # @return void
      def after_delete(&block); end
      
      # @method after_validate(&block)
      # Add a block to be executed after an object is validated.
      # 
      # @return void
      def after_validate(&block); end
      
      %w(create save update validate delete).each do |stage|
        
        # after methods        
        module_eval <<-"end_eval"
          def after_#{stage}(&block)
            @blocks = Hash.new if @blocks.nil?
            stage = "#{stage}"
            if block_given?
              # Set block
              @blocks[stage] = block
            else
              super              
              # Retrieve, call, and delete Block
              call_block("#{stage}")
            end
            self
          end
        end_eval
      end
      
      # Pass a block to this method, and chain with Ohm methods like ``save`` and ``create``
      # to have that block of code called when those transactions are finalized, asynchronously.
      # The block will be called with an array of model objects, updated from remote.
      #
      # @param [Block] block of code to be executed. One parameter -- the second set of records -- will be passed to the block.
      def after(&block)
        if block_given?
          @temp_block = block
        end
        self
      end
      
      private
      
      def call_block(stage) # :nodoc:
        if @temp_block.present? and stage.to_sym == :save
          @blocks[stage] = @temp_block
          @temp_block = nil
        end
        return if @blocks[stage].nil?
        method = :remote_after_#{stage}
        args = {}                
        args = self.send method if self.respond_to? method
        @blocks[stage].call args
        @blocks.delete stage
      end
      
    end
  end
end