class User < ActiveRecord::Base

  has_many :reviews, -> { order("created_at DESC")}
  has_many :queue_items, -> { order("ranking") }

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                  class_name: "Relationship",
                                  dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_secure_password validation: false

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :full_name, presence: true

  validates_presence_of :password, :password_confirmation, on: :create
  validates_length_of :password, :password_confirmation,
                      minimum: 5, on: :create, too_short: 'please enter at least 6 characters'


  def reset_order_ranking
    items = queue_items
    for i in (0...(items.count))
      items[i].update(ranking: i + 1 )
    end
  end

  def queued?(video_id)
    queue_items.map(&:video_id).include?(video_id)
  end

  def follow(another_user)
    relationships.create(followed: another_user)
  end
end
