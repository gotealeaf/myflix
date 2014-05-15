class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items, -> { order(:order) }

  has_many :relationships
  has_many :followers, through: :relationships

  has_many :reverse_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followed_people, through: :reverse_relationships, source: :user

  before_create :generate_token
  
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password 

  def normalize_queue_positions 
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(order: index + 1)
    end    
  end

  def queued_video? video
    queue_items.map(&:video).include? video
  end  

  def count_queued_videos
    queue_items.count
  end

  def follows? user
    reverse_relationships.exists?(user: user)
  end  

  def can_follow? user
    !(self.follows?(user) || self == user)
  end

  def to_param
    token
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

  def reset_passsword password
    self.password = password
    self.password_confirmation = password
    self.generate_token
    self.save
  end
end