Dir[File.dirname(__FILE__) + '/jobs/*.rb'].each {|file| require file }

class Ohm::Asynchronous::Adapters::DelayedJob < Ohm::Asynchronous::Adapters::Default
  
  def self.execute_block_later(&block)
    puts "Delayed Job with #{block}."
    self.delay.call_block(block)
  end
  
  def self.call_block(&block)
    block.call
  end
  
end