class Relationship < ActiveRecord::Base
  belongs_to :leader, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates_uniqueness_of :leader_id, scope: [:follower_id], message: "You are already following that person."
  validate :user_does_not_follow_self

  def user_does_not_follow_self
    self.errors.add(:base, 'You cannot follow yourself.') if self.leader_id == self.follower_id
  end
end