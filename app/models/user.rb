class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password_digest, presence: true
  has_many :reviews, -> { order("created_at DESC")}
  has_many :queue_items, -> { order(:position)}

  has_many :relationships, -> { order("created_at DESC")}  #user_id points back to self
  has_many :followers, :through => :relationships #relation_id points to follower
  has_many :leads, :class_name => "Relationship", :foreign_key => "follower_id" #self is the follower_id
  has_many :leaders, :through => :leads, :source => :user #collection of users for which self is follower_id



  has_secure_password

  def normalize_positions
    queue_items.each_with_index do |q, i|
      # index starts at 0, position at 1
      q.update_attributes(position: i + 1)
    end
  end
end
