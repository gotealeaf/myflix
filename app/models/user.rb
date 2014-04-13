class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: :true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :full_name, presence: true

  has_many :reviews,  -> { order(created_at: :desc) }
  has_many :queue_items, -> { order(position: :asc) }
  has_many :videos, through: :queue_items

  has_secure_password

  def update_queue_items(queue_items_data)
    ActiveRecord::Base.transaction do
      queue_items_data.each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data[:id].to_i)
        queue_item.update!(position: queue_item_data[:position]) if queue_item.user == self
      end
    end
  end

  def normalize_queue_items_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update(position: index + 1)
    end
  end
end