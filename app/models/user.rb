class User < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc) }
  has_many :queue_items, -> { order(:position) } 
  has_many :followings
  has_many :followed_users, through: :followings
  has_many :inverse_followings, class_name: "Following", foreign_key: "followed_user_id"
  has_many :followers, through: :inverse_followings, source: :user
  
  validates_presence_of :fullname, :email, :password
  validates_uniqueness_of :email

  has_secure_password validations: false

  def next_available_queue_position
    queue_items.count + 1
  end

  def normalize_position
    queue_items.each_with_index do |item, index|
      item.update_attributes(position: index + 1)
    end 
  end

  def video_in_queue?(video)
    queue_items.ids.include?(video.id)
  end

  def can_follow?(another_user)
   !(self.followed_users.include?(another_user) || self == another_user)
  end
end