class User < ActiveRecord::Base
  include Sluggable
  sluggable_column :full_name

  before_save :generate_token!

  has_many :reviews, -> { order("created_at DESC")}
  has_many :queue_items, -> { order("ranking") }

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                  class_name: "Relationship",
                                  dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :invitations, foreign_key: "inviter_id"


  has_secure_password validation: false

  validates :email, presence: true,
                    format: { with: /@/ },
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

  def follow(another_user)
    relationships.create(followed: another_user)
  end

  def queued?(video)
    queue_items.map(&:video).include?(video)
  end

  def following?(another_user)
    relationships.map(&:followed).include?(another_user)
  end

  def cant_follow(user)
    self == user || self.following?(user)
  end

  private

    def generate_token!
      self.token = SecureRandom.urlsafe_base64
    end

end
