require 'resque'

module ResqueExecuteBlockLaterJob

  @queue = :default

  def self.perform(*args)
    sleep 2
    block = args.shift
    block.call args
  end
  
end