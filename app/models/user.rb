class User < ActiveRecord::Base
  has_secure_password validations: false
  validates :password, on: :create, length: { minimum: 8 }, confirmation: true
  validates :password_confirmation, presence: true
  validates_presence_of :username, :full_name, :email, :password, :password_confirmation
  validates_uniqueness_of :email, :username

  has_many :reviews, -> { order(created_at: :desc) }
  has_many :queue_videos, -> { order(:position) }
  has_many :followings
  has_many :followees, through: :followings
  has_many :user_tokens
  has_many :payments

  def normalise_queue_positions
    queue_videos.each_with_index do |position, index|
      position.update(position: index + 1)
    end
  end

  def video_in_queue?(video)
    queue_videos.find_by(video: video).present?
  end

  def count_queue_videos
    queue_videos.present? ? queue_videos.count : 0
  end

  def count_reviews
    reviews.present? ? reviews.count : 0
  end

  def admin?
    admin == true
  end

  def active?
    status == 'active'
  end

  def deactivate!
    update_column(:status, 'inactive')
  end
end
