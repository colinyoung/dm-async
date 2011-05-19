module Ohm
  module Asynchronous
    module CallbackMethodDefinitions
      
      # %w(create save update validate delete).each do |method|
      #   %w(before after).each do |phase|
      #     module_eval <<-"end_eval"
      #       def #{phase}_#{method}()
      #         name = "=> #{phase} #{method}:"
      #         puts name
      #         super
      #       end
      #     end_eval
      #   end
      # end
      
      def after_save(*args)
       self.class.call_block @block_id, nil
      end
      
    end
  end
end