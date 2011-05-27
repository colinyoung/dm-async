module SampleHandlers
  
  def self.included(base); base.extend(Methods); end
  
  module Methods
  
    def remote_after_find
      sleep 4      
      ["apples"]
    end
  
  	def remote_after_save
  	  {:response => {}, :code => 200}
  	end
	
  end
  	
end