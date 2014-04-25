class Invitation < ActiveRecord::Base
  belongs_to :inviter, foreign_key: "inviter_id", class_name: "User"

  validates :recipient_name, presence: true, length: {minimum: 3}
  validates :recipient_email, presence: true
  validates :message, presence: true, length: {minimum: 10}

  validate :invitation_is_not_created_for_existing_user

  before_create :generate_token

  def invitation_is_not_created_for_existing_user
    if User.all.map(&:email).include?(self.recipient_email)
      self.errors.add(:email, "User is already signed up")
    end
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end