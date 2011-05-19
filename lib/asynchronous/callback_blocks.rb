module Ohm
  module Asynchronous
    module CallbackBlocks
      
      attr_accessor :blocks
      attr_accessor :temp_block
        
      %w(create save update validate delete).each do |stage|
        
        # after methods        
        module_eval <<-"end_eval"
          def after_#{stage}(&block)
            @blocks = Hash.new if @blocks.nil?
            stage = "#{stage}"
            if block_given?
              # Set block
              puts "Setting block for stage: #{stage}"
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
      
      def async(&block)
        if block_given?
          @temp_block = block
          puts "Set temp block."
        end
        self
      end
      
      def call_block(stage)
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