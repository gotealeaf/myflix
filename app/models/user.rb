class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order('position') } 
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password validations: false

  def repositions_queue_items
    queue_items.each_with_index do |queue_item, index|
      queue_item.update(position: index+1)
    end
  end 

  def queued_item?(video=nil)
    collection = queue_items.map(&:video)
    collection.include?(Video.find(video.id))
  end

  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy
  end
end