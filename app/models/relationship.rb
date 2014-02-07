class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: 'User'
  belongs_to :leader, class_name: 'User'

  validates_presence_of :follower, :leader
  validates_uniqueness_of :leader_id, scope: :follower_id

  def self.find_by_user_and_leader(following_user, leading_user)
    self.where(follower: following_user, leader: leading_user).first
  end
end
