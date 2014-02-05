class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :leader, class_name: 'User'

  validates_presence_of :user, :leader
  validates_uniqueness_of :leader_id, scope: :user_id

  def self.find_by_user_and_leader(following_user, leading_user)
    self.where(user: following_user, leader: leading_user).first
  end
end
