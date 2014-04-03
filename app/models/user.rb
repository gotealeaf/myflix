class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order("position") }

  has_secure_password validations: false

  validates :name, presence: true,
                   length: { minimum: 1, maximum: 30 }

  validates :email, presence: true,
                    uniqueness: true#,
                    #length: { minimum: 6, maximum: 50 }

  validates :password, presence: true,
                       length: { minimum: 6 }


  def renumber_positions
    queue_items.each_with_index do |item, index|
      QueueItem.find(item.id).update_attributes(position: (index+1) )
    end
  end

  def next_position
    (queue_items.count + 1)
  end
end
