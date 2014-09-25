class Invitation < ActiveRecord::Base
  validates :recipient_email, presence: true
  validates :recipient_name, presence: true
  validates :message, presence: true

  belongs_to :inviter,   :class_name => "User"
end
