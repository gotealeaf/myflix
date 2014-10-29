class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :following, class_name: 'User', foreign_key: 'following_id'
  
  validates_uniqueness_of :following_id, :scope => :follower_id
  validate :disallow_self_referential_friendship

  def disallow_self_referential_friendship
    if follower_id == following_id
      errors.add(:follower_id, 'cannot be the same person as the one being followed')
    end
  end
end