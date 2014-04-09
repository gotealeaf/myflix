class Invitation < ActiveRecord::Base
  require_relative "../../lib/tokenable"

before_create :set_invitation_token

validate  :friend_is_not_already_registered, on: :create
validates :inviter_id, presence: true
validates :friend_name, presence: true
validates :friend_email, presence: true
validates :message, presence: true


  def friend_is_not_already_registered
    errors.add(:base, "Friend's email is already registered MyFLiX.") unless User.find_by(email: self.friend_email).blank?
  end

  def self.generate_token
    SecureRandom.urlsafe_base64
  end

  def set_invitation_token
    self.token = User.generate_token
  end

  def clear_invitation_token
    update_columns(token: nil)
  end
end
