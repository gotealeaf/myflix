class Invitation < ActiveRecord::Base
  #require_relative "../../lib/tokenable"
  include Tokenable

validate  :friend_is_not_already_registered, on: :create
validates :inviter_id, presence: true
validates :friend_name, presence: true
validates :friend_email, presence: true
validates :message, presence: true


  def friend_is_not_already_registered
    errors.add(:base, "Friend's email is already registered MyFLiX.") unless User.find_by(email: self.friend_email).blank?
  end

  def self.secure_token
    SecureRandom.urlsafe_base64
  end

  def clear_invitation_token
    update_columns(token: nil)
  end
end
