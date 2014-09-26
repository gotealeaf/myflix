class Invitation < ActiveRecord::Base
  validates :recipient_email, presence: true
  validates :recipient_name, presence: true
  validates :message, presence: true

  belongs_to :inviter,   :class_name => "User"

  before_create :generate_token

  def generate_token
    self.token = SecureRandom::urlsafe_base64
  end
end
