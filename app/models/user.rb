class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order(:order) }
  
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password 

  def normalize_queue_positions 
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(order: index + 1)
    end    
  end
end