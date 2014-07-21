class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :followed_users, class_name: "User", foreign_key: "followed_user_id"

  validates_uniqueness_of :followed_user_id, scope: :user_id
end