module DataMapper
  module Asynchronous
    module CallbackBlocks
      
      STAGES = %w(create save update validate delete find)
        
      attr_accessor :blocks
      attr_accessor :temp_block
      attr_accessor :operations
      module ClassMethods
        mattr_accessor :instance
        mattr_accessor :blocks
        mattr_accessor :temp_block
        mattr_accessor :operations
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
            def after_#{stage}(*args, &block)
              @blocks = Hash.new if @blocks.nil?
              @operations = [] if @operations.nil?
              stage = "#{stage}"
              if block_given?
                # Set block
                @blocks[stage] = block
              else
                super unless stage == "find"
                # Retrieve, call, and delete Block
                puts "==> Scheduled block at #{Time.now}"
                @operations << self.async_adapter.execute_block_later do 
                  call_block("#{stage}", args)
                end
              end
              self
            end
          end_eval
                    
        end
      end
      
      STAGES.each do |stage|
        
        eval <<-"end_eval"
          def after_#{stage}(*args)
            return if ["save", "destroy"].include? "#{stage}" # @temp_block is only executed on `save` 
                                                              # and `destroy`,  which always mark the 
                                                              # last steps in an object's lifecycle.
            @operations = [] if @operations.nil?                                                              
            self.class.log "Adding block for #{stage}."
            @operations << self.async_adapter.execute_block_later do 
              call_block("#{stage}", args)
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
        def all(*args)
          unless args.include?(:synchronous)
            after_find(args)
          else
            args.delete :synchronous
          end
          
          args.count > 0 ? super(args) : super({})
        end
        
        def all!(*args)
          all(args.merge(:synchronous))
        end
      end
      
      
      # Utility methods
      
      # def call_block(stage)
      # Class Version
      module ClassMethods; def call_block(stage, args_for_remote) # :nodoc:
        return if @blocks[stage].nil? and @temp_block.nil?
        method = "remote_after_#{stage}".to_sym
        remote_response = {}
        remote_response = @instance.send(method, args_for_remote) if @instance.respond_to? method
        if remote_response == {}
          remote_response = self.send(method, args_for_remote) if self.respond_to? method
        end
        
        # Now, call the model's callbacks (after_#{stage}, etc.)
        if !@blocks[stage].nil?
          # Call class event first
          @instance.present? ? @blocks[stage].call(@instance, remote_response) : @blocks[stage].call(remote_response)
        end
        if @temp_block
          @instance.present? ? @temp_block.call(@instance, remote_response) : @temp_block.call(remote_response)
          @temp_block = nil
        end
      end; end
      
      # Instance version
      def call_block(stage, args_for_remote)
        return if @temp_block.nil?
        log "Call block - instance - after_#{stage}"
        method = "remote_after_#{stage}".to_sym
        
        remote_response = {}
        remote_response = self.send(method, args_for_remote) if self.respond_to? method
        self.class.call_block(stage) # Call class event first        
        @temp_block.call remote_response
        @temp_block = nil
      end
      
      module ClassMethods
        def log(msg)
          if defined? Rails
            @logfile = Rails.root.join('log', 'ohm_async.log')
            File.open(@logfile, 'a') {|f| f.puts("[#{Time.now}] #{msg}") }
          else
            puts msg
          end
        end
        
        # Finish immediately
        def finish!
          arr = []
          @operations.each do |op|
            arr << op.pop.join
          end
          arr
        end
      end
      
    end
  end
end