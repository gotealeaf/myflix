class Invitation < ActiveRecord::Base
  include Tokenable

  belongs_to :inviter, foreign_key: "inviter_id", class_name: "User"

  validates :recipient_name, presence: true, length: {minimum: 3}
  validates :recipient_email, presence: true
  validates :message, presence: true, length: {minimum: 10}

  validate :invitation_is_not_created_for_existing_user

  def invitation_is_not_created_for_existing_user
    if User.all.map(&:email).include?(self.recipient_email)
      self.errors.add(:recipient_email, "is already signed up")
    end
  end
end