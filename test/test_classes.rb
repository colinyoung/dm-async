class Store < Ohm::Asynchronous::Model
  attribute :name
  attribute :city
  
  handle_remotes_with :remote_handlers
  
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