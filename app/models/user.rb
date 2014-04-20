class User < ActiveRecord::Base
  #require_relative "../../lib/tokenable"
  include Tokenable

  has_many :reviews,     -> { order("created_at DESC") }, class_name: "Review"
  has_many :queue_items, -> { order("position"       ) }, class_name: "QueueItem"
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id  #fk = reference to person who is doing the looking for things
  has_many :leaders,    through: :following_relationships#things looking for. Source is the name of this thing in the join table. If same - not needed.
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id
  has_many :followers,  through: :leading_relationships #things looking for. Source is name of the "things" if differs from name in join table

  has_secure_password validations: false

  before_create :set_initial_prt_time


  validates :name,     presence: true,
                       length: { minimum: 1, maximum: 30 }

  validates :email,    presence: true,
                       uniqueness: true#,
                       #length: { minimum: 6, maximum: 50 }

  validates :password, presence: true,
                       length: { minimum: 6 }



  def renumber_positions
    queue_items.each_with_index do |item, index|
      item.update_attributes(position: (index+1) )
    end
  end

  def next_position
    (queue_items.count + 1)
  end

  def has_this_video_in_queue?(video)
    queue_items.map(&:video_id).include?(video.id)
  end

  def can_follow?(user)
    true unless (user == self) || (leaders.include?(user))
  end

  def follow(user)
    following_relationships.create(leader: user)
  end

  def self.secure_token
    SecureRandom.urlsafe_base64
  end

  def set_initial_prt_time
    self.prt_created_at = 1.day.ago
  end

  def token_expired?(timeframe)
    prt_created_at.nil? ? true : prt_created_at < timeframe.hours.ago
  end

  def set_token_data_invalid
    update_columns(token: User.secure_token,
                   prt_created_at: 1.day.ago)
  end
end
