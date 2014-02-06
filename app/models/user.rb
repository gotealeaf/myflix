class User < ActiveRecord::Base
  has_many :reviews, -> { order('created_at DESC') }
  has_many :queue_items, -> { order('ranking') }
  has_many :videos, through: :queue_items
  has_many :leader_relationships, -> { order('created_at DESC') },
           class_name: "Relationship",
           foreign_key: :follower_id,
           dependent: :destroy
  has_many :leaders, through: :leader_relationships, source: :leader
  has_many :follower_relationships, -> { order('created_at DESC') },
           class_name: "Relationship",
           foreign_key: :leader_id,
           dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password :validations => false

  def renumber_queue
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(ranking: index+1)
    end
  end

  def queue_video(video)
    video.queue_items.create(user: self, ranking: next_queue_item_rank) unless queued_video?(video) 
  end

  def following?(other_user)
    leaders.include?(other_user)
  end

  def allow_to_follow?(other_user)
    !following?(other_user) && self != other_user
  end

  private

  def next_queue_item_rank
    queue_items.count + 1
  end

  def queued_video?(video)
    video.queue_items.find_by_user_id(id)
  end
end