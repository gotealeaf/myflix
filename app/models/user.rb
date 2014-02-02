class User < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc) }
  has_many :queue_items, -> { order(position: :asc, created_at: :desc) }

  validates :email, presence: true, uniqueness: true
  validates_presence_of :full_name

  has_secure_password validations: false
  validates_presence_of :password

  def has_queued_video?(video)
    self.queue_items.map(&:video).include?(video)
  end

  def sort_queue_items_by_position
    self.break_position_ties
    self.fill_queue_item_position_gaps
  end

  def break_position_ties
    self.queue_items.each_with_index { |item, index| item.position = index }
  end

  def fill_queue_item_position_gaps
    self.queue_items.reload.each_with_index do |item, index|
      if item.position != index + 1
        item.position = index + 1
        item.save
      end
    end
  end
end
