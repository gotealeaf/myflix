class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates_presence_of :follower, :followed
  validates :follower_id, uniqueness: { scope: :followed_id }
  validate :cant_follow_yourself

  private

    def cant_follow_yourself
      return if follower_id != followed_id
      errors[:base] << "You cannot follow yourself."
    end
end
