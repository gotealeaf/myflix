class User < ActiveRecord::Base

  has_secure_password validations: false
  has_many :queue_items, -> { order(:position) }
  has_many :reviews, -> {order("created_at DESC")}
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
    
  validates_presence_of :email, :password, :full_name

  def normalize_queue_item_positions
    queue_items.each_with_index  do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end
  end

  def queued_video_previsouly?(video)
    queue_items.map(&:video).include?(video)
  end

  def has_queued_video?(video)
    queue_items.pluck(:video_id).include?(video.id)
  end

  def follows?(another_user)
    # following_relationships.map(&:leader).include?(another_user)
    following_relationships.pluck(:leader_id).include?(another_user.id)
  end

  def can_follow?(leader)
      !(self.follows?(leader) || self == leader)
  end
end


