class Invitation < ActiveRecord::Base
  belongs_to :inviter, class_name: User
  before_create :generate_token

  validates_presence_of :guest_email, :guest_name, :message

  def generate_token
    self.invitation_token = SecureRandom.urlsafe_base64
  end
end