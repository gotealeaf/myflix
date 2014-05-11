class UserRelationship < ActiveRecord::Base
  belongs_to :followee, class_name: :User, foreign_key: :user_id
  belongs_to :follower, class_name: :User

  validates :followee, uniqueness: { scope: :follower_id }
end