require 'yaml'

class Ohm::Asynchronous::Adapters::Threading < Ohm::Asynchronous::Adapters::Default
  
  def self.execute_block_later(&block)
    log "Adding a new Job with #{block}."
    t = Thread.new do
      monitor = BlockMonitor.new(block)
      monitor.perform
    end
  end
  
  def self.log(msg)
    @logfile = $stdout
    if defined? Rails
      @logfile = Rails.root.join('log', 'ohm_async_threading.log')
    end
    @logfile ||= File.join(File.dirname(__FILE__), 'log', 'threading.log')
    File.open(@logfile, 'a') {|f| f.puts("#{msg}") }
  end
  
end

class BlockMonitor < Struct.new(:block)
  
  def self.log(msg)
    Ohm::Asynchronous::Adapters::Threading.log msg
  end
  
  def perform
    if RUBY_VERSION.to_f > 1.8
      self.class.log "Executing block from #{block.source_location}..."
    else
      self.class.log "Executing block with ID #{self.to_s}..."
    end
    
    before
    result = block.call
    if result === false
      failure(result)
    else
      success(result)
    end
    after
  end
  
  def before
    self.class.log "[Block:#{self.to_s}] ==> before"
  end
  
  def after
    self.class.log "[Block:#{self.to_s}] ==> after"
  end

  def failure(result)
    self.class.log result.to_yaml
    self.class.log "[Block:#{self.to_s}] FAILURE with error: #{result}"
  end
  
  def success(result)
    self.class.log "[Block:#{self.to_s}] SUCCESS OK\nValue: #{result.to_yaml}"
  end
  
  def to_s
    "##{self.object_id}"
  end
end