class User < ActiveRecord::Base
  has_many :queue_items, -> { order :position }
  has_many :reviews, -> { order "created_at DESC" }
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id

  has_secure_password validations: false

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :full_name, presence: true

  before_create :generate_token

  def normalize_queue_item_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  # passes tests, but didn't work on UI because not looking up in specific user's queue_items
  # QueueItem.exists?(video)
  end

  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
    # original idea for this passing in leader/follower instead of another_user
    # Relationship.exists?(leader_id: leader.id, follower_id: follower.id)
  end

  def can_follow?(another_user)
    !(self.follows?(another_user) || self == another_user)
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

end
