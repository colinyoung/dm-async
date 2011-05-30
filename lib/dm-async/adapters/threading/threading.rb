require 'yaml'

class DataMapper::Asynchronous::Adapters::Threading < DataMapper::Asynchronous::Adapters::Default
  
  attr_accessor :queue
  
  def self.execute_block_later(&block)
    log "Adding a new Job with #{block}."
    @queue ||= Queue.new
    @queue << Thread.new do
      monitor = BlockMonitor.new(block)
      result = monitor.perform
    end
  end
  
  def self.log(msg)
    @logfile = $stdout
    if defined? Rails 
      @logfile = Rails.root.join('log', 'ohm_async_threading.log')
      File.open(@logfile, 'a+') {|f| f.puts("#{msg}") }
    else
      @logfile = File.join(LOGDIR, 'ohm_async_threading.log')
      # $stdout.puts msg
      File.open(@logfile, 'a+') {|f| f.puts("#{msg}") }
    end
  end
  
end

class BlockMonitor < Struct.new(:block)
  
  def self.log(msg)
    DataMapper::Asynchronous::Adapters::Threading.log msg
  end
  
  def perform
    if RUBY_VERSION.to_f > 1.8
      self.class.log "Executing block from #{block.source_location}..."
    else
      self.class.log "[Block:#{self.to_s}] ==> Executing..."
    end
    
    before
    result = block.call
    # @todo if the block fails, the thread stops and no exceptions are caught...
    if result === false
      failure(result)
    else
      success(result)
    end
    after
  end
  
  def before
    self.class.log "[Block:#{self.to_s}] before()"
  end
  
  def after
    self.class.log "[Block:#{self.to_s}] after()"
  end

  def failure(result)
    self.class.log result.to_yaml
    self.class.log "[Block:#{self.to_s}] ==> FAILURE with error: #{result}"
  end
  
  def success(result)
    self.class.log "[Block:#{self.to_s}] ==> SUCCESS, Model returned '#{result}'"
  end
  
  def to_s
    "##{self.object_id}"
  end
end