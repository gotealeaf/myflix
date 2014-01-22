class User < ActiveRecord::Base

  validates_presence_of :email, :password, :full_name

  has_secure_password validations: false
  has_many :queue_items, -> { order(:position) }

  def normalize_queue_item_positions
    queue_items.each_with_index  do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end
  end

end
