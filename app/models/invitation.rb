class Invitation < ActiveRecord::Base
  validates :inviter, presence: true
  validates :invitee_email, presence: true

  belongs_to :inviter, class_name: :User, foreign_key: :user_id
end