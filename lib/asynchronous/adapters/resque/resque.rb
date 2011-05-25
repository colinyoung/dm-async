# NOTE: Resque cannot execute blocks yet.
# It is rumored to include this later, so I'm leaving
# this file here for now.

Dir[File.dirname(__FILE__) + '/jobs/*.rb'].each {|file| require file }

class Ohm::Asynchronous::Adapters::Resque < Ohm::Asynchronous::Adapters::Default
      
  def self.execute_block_later(&block)
    super block
    puts block.to_yaml
    ::Resque.enqueue(ResqueExecuteBlockLaterJob, block)
    puts "Enqueued block"
  end
  
end