class User < ActiveRecord::Base
  include Tokenable
  validates_presence_of :fullname, :email, :password
  validates_uniqueness_of :email

  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items, -> { order(:position) }
  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id"
  has_many :leading_relationships, class_name: "Relationship", foreign_key: "leader_id"
  has_secure_password validations: false

  def normalize_queue_item_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end

  def follow(user)
    self.following_relationships.create(leader: user) if self.can_follow?(user)
  end

  def follows?(user)
    self.following_relationships.map(&:leader).include?(user)
  end

  def can_follow?(user)
    !(self.follows?(user) || self == user)
  end

  def deactivate!
    update_column(:active, false)
  end
end
