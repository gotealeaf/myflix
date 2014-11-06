class User < ActiveRecord::Base
  
  has_secure_password validations: false
  
  has_many :reviews, -> { order('created_at DESC') }
  has_many :queue_items, -> { order(:position) }
  
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "following_id"
  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id"

  has_many :follower_users, through: :follower_relationships, source: :follower
  has_many :following_users, through: :following_relationships, source: :following
  
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
  end
  
  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
  
end