class Invitation < ActiveRecord::Base
  validates :user, presence: true
  validates :invitee_email, presence: true

  belongs_to :user
end