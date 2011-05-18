module Ohm
  module Asynchronous
    class Model < Ohm::Model
      
      def self.included(base)
        base.extend(ClassMethods)
      end
      
    end
  end
end
