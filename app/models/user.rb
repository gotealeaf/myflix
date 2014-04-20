class User < ActiveRecord::Base
  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items, -> { order(:position) }

  has_many :relationships
  has_many :followers, through: :relationships
  has_many :leader_relationships, foreign_key: "follower_id", class_name: "Relationship"
  has_many :leaders, through: :leader_relationships, source: :user
  
  validates :full_name, presence: true, length: {minimum: 3}
  validates :email, presence: true, uniqueness: true, length: {minimum: 6}
  validates :password, presence: true, on: :create, length: {minimum: 5}

  has_secure_password validations: false

  def normalize_queue_item_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end
end