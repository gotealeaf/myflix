class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :queue_items, -> { order 'position ASC' }
  validates :email, uniqueness: true, presence: true
  validates :fullname, presence: true
  has_many :reviews

  def normalise_queue
    queue_count = 0
    queue_items.each do |queue_item|
      queue_count = queue_count + 1
      queue_item.update_column(:position, queue_count)
    end
  end

  def number_of_queue_items
    total = queue_items.count
    total
  end
end
