module SampleHandlers
  
  def remote_after_find
    ["apples"]
  end
  
	def remote_after_save
	  {:response => {}, :code => 200}
	end
  	
end