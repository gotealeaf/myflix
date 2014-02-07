class User < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc) }
  has_many :queue_items, -> { order(position: :asc, created_at: :desc) }
  has_many :relationships, foreign_key: 'follower_id'
  has_many :leaders, through: :relationships
  has_many :inverse_relationships, class_name: 'Relationship', foreign_key: 'leader_id'
  has_many :followers, through: :inverse_relationships, source: :follower

  validates :email, presence: true, uniqueness: true
  validates_presence_of :full_name

  has_secure_password validations: false
  validates_presence_of :password

  def has_queued_video?(video)
    self.queue_items.map(&:video).include?(video)
  end

  def normalize_queue_positions
    self.queue_items.each_with_index do |item, index|
      item.position = index + 1
      item.save
    end
  end

  def reviews_with_rating
    reviews.where.not(rating: nil)
  end

  def follows?(leader)
    self.leaders.include?(leader)
  end

  def can_follow?(user)
    self != user && !self.follows?(user)
  end

  def generate_password_reset_token
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.save(validate: false)
  end
end
