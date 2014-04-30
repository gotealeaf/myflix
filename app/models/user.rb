class User < ActiveRecord::Base
  include Tokenable

  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items, -> { order(:position) }
  has_many :invitations, foreign_key: "inviter_id"

  has_many :followers, through: :leading_relationships
  has_many :leaders, through: :following_relationships

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship"
  has_many :leading_relationships, foreign_key: "leader_id", class_name: "Relationship"
  
  validates :full_name, presence: true, length: {minimum: 3}
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 5}

  has_secure_password validations: false

  def normalize_queue_item_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end

  def follow!(another_user)
    following_relationships.create(leader: another_user)
  end

  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end

  def change_token
    update_attributes(token: SecureRandom.urlsafe_base64)
  end
end