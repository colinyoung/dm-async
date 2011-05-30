class DataMapper::Asynchronous::Adapters::DelayedJob < DataMapper::Asynchronous::Adapters::Default
  
  def self.execute_block_later(&block)
    log "adding a new Job with #{block}."
    ::Delayed::Job.enqueue(DelayedJobClass.new(block, @logfile))
  end
  
  def self.log(msg)
    @logfile = $stdout
    if defined? Rails
      @logfile = Rails.root.join('log', 'ohm_async_delayed_job.log')
    end
    @logfile ||= File.join(File.dirname(__FILE__), 'log', 'delayed_job.log')
    File.open(@logfile, 'a') {|f| f.puts("\n" + msg) }
  end
  
end

class DelayedJobClass < Struct.new(:block, :logfile)
  
  def perform
    Pusher['new_records'].trigger!('performed', "performed in Delayed Job queue")
    log "Perform job"
    block.call
  end
  
  def before
    log "before job"
    Pusher['new_records'].trigger!('before', "before in Delayed Job queue")
  end
  
  def after
    log "after job"
    Pusher['new_records'].trigger!('after', "after in Delayed Job queue")
  end
  
  def error
    log "error w/ job"
    Pusher['new_records'].trigger!('error', "error in Delayed Job queue")
  end
  
  def success
    log "success w/ job"
    Pusher['new_records'].trigger!('success', "success in Delayed Job queue")
  end
  
  def failure
    log "absolute failure"
    Pusher['new_records'].trigger!('failure', "TOTAL FAILURE")
  end
  
  def log(msg)
    File.open(@logfile, 'a') {|f| f.puts("\n" + msg) }
  end
end