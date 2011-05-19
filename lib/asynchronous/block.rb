module Ohm
  module Asynchronous
    module Block
      
      @@blocks = {}
      
      def add_block(name, block)
        puts "adding block: #{name}"
        @@blocks = Hash.new if @@blocks.nil?
        @@blocks[name] = block
      end

      def call_block(name, arg)
        @@blocks[name].call(arg)
      end
    end
  end
end