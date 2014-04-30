class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: :true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :full_name, presence: true

  has_many :reviews,  -> { order(created_at: :desc) }
  has_many :queue_items, -> { order(position: :asc) }
  has_many :videos, through: :queue_items
  has_many :user_relationships
  has_many :followers, through: :user_relationships
  has_many :following_relationships, class_name: :UserRelationship, foreign_key: :follower_id
  has_many :followees, through: :following_relationships
  
  has_secure_password

  def normalize_queue_items_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update(position: index + 1)
    end
  end

  def queued_video?(video)
    videos.include?(video)
  end

  def follows?(user)
    followees.include?(user)
  end

  def can_follow?(user)
    true unless self.follows?(user) || self == user
  end

  def generate_password_token
    self.update(password_token: SecureRandom.urlsafe_base64)
    self.password_token
  end
end