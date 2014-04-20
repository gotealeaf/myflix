class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :follower, class_name: "User"

  validates_uniqueness_of :user_id, scope: [:follower_id], message: "has already been followed by you."
  validate :user_does_not_follow_self

  def user_does_not_follow_self
    self.errors.add(:base, 'You cannot follow yourself.') if self.user_id == self.follower_id
  end
end