class User < ActiveRecord::Base

has_secure_password validations: false

has_many :reviews
has_many :queue_items, -> {order(:position)}  #by default it is in ascending order

validates_presence_of :email, :password, :full_name
validates_uniqueness_of :email

  def normalize_queue_item_positions
   queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
      
    end
    
  end
end
