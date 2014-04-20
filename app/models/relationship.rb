class Relationship < ActiveRecord::Base
belongs_to :leader, class_name: 'User'
belongs_to :follower, class_name: 'User'

validate :user_cannot_follow_self
validates_uniqueness_of :leader_id,   scope: [:follower_id]

  private
    def user_cannot_follow_self
      errors.add(:base, "No following yourself.") if self.leader_id == self.follower_id
    end
end
