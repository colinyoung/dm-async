class RedisStore
  include DataMapper::Resource
  include DataMapper::Asynchronous
  
  property :name, String
  property :city, String
  
	include SampleHandlers
	
  # after_find do |new_sets|
  #   puts "Record: #{new_sets.to_json}"
  #   puts "!!! Class-level after find"
  # end
  
  after_save do |record, new_sets|
    puts "Record: #{record.to_json}"
    puts "!!! Class-level after save"
  end
  
  def to_hash
    # Ohm requires to you whitelist attributes in to_hash.
    {:city => city, :id => id}
  end
  
  def before_save
    puts "Before save..."
    sleep 1
    super
  end
  
  def after_save
    puts "After save..."
    sleep 1
    super
  end
end