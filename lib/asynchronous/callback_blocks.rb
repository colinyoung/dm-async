module DataMapper
  module Asynchronous
    module CallbackBlocks
      
      STAGES = %w(create save update validate delete find)
      
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      attr_accessor :blocks
      attr_accessor :temp_block
      
      module ClassMethods
        attr_accessor :instance
        attr_accessor :blocks
        attr_accessor :temp_block
      end
      
      # @method after_find(&block)
      # Add a block to be executed after records are found.
      # 
      # @return void
      def self.after_find(&block); end
      
      # @method after_create(&block)
      # Add a block to be executed after an object is created.
      # 
      # @return void
      def self.after_create(&block); end
      
      # @method after_save(&block)
      # Add a block to be executed after an object is saved.  This is the default for the `after` method.
      # 
      # @return void
      def self.after_save(&block); end      
      
      # @method after_update(&block)
      # Add a block to be executed after an object is updated.
      # 
      # @return void
      def self.after_update(&block); end      
      
      # @method after_delete(&block)
      # Add a block to be executed after an object is deleted.
      # 
      # @return void
      def self.after_delete(&block); end
      
      # @method after_validate(&block)
      # Add a block to be executed after an object is validated.
      # 
      # @return void
      def self.after_validate(&block); end
      
        
      # after methods
      module ClassMethods
        
        STAGES.each do |stage|
        
          module_eval <<-"end_eval"
            def after_#{stage}(&block)
              @blocks = Hash.new if @blocks.nil?
              stage = "#{stage}"
              if block_given?
                # Set block
                @blocks[stage] = block
              else
                super unless stage == "find"
                # Retrieve, call, and delete Block
                # log "Adding block for #{stage}."
                self.adapter.execute_block_later do 
                  call_block("#{stage}")
                end
              end
              self
            end
          end_eval
                    
        end
      end
      
      STAGES.each do |stage|
        
        eval <<-"end_eval"
          def after_#{stage}
            self.class.instance ||= self
            return if ["save", "destroy"].include? "#{stage}" # @temp_block is only executed on `save` 
                                                              # and `destroy`,  which always mark the 
                                                              # last steps in an object's lifecycle.
            # self.class.log "Adding block for #{stage}."
            self.class.adapter.execute_block_later do 
              call_block("#{stage}")
            end
          end
        end_eval
        
      end
      
      # Pass a block to this method, and chain with resource methods like ``save`` and ``create``
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
      
      module ClassMethods; def after(&block)
        if block_given?
          @temp_block = block
        end
        self
      end; end
      
      # Overridden methods      
      module ClassMethods
        def all
          after_find
          super
        end
      end
      
      
      # Utility methods
      
      # def call_block(stage)
      # Class Version
      module ClassMethods; def call_block(stage) # :nodoc:
        return if @blocks[stage].nil? and @temp_block.nil?
        # log "Call block - class - after_#{stage}"
        method = "remote_after_#{stage}".to_sym
        args = {}
        args = self.send method if self.respond_to? method
        if !@blocks[stage].nil?
          @blocks[stage].call @instance, args # Call class event first
        end
        if @temp_block
          @temp_block.call @instance, args
          @temp_block = nil
        end
      end; end
      
      # Instance version
      def call_block(stage)
        return if @temp_block.nil?
        # log "Call block - instance - after_#{stage}"
        method = "remote_after_#{stage}".to_sym
        args = {}                
        args = self.send method if self.respond_to? method
        self.class.call_block(stage) # Call class event first        
        @temp_block.call args
        @temp_block = nil
      end
      
      module ClassMethods; def log(msg)
        if defined? Rails
          @logfile = Rails.root.join('log', 'ohm_async.log')
          File.open(@logfile, 'a') {|f| f.puts("[#{Time.now}] #{msg}") }
        end
      end; end
      
    end
  end
end