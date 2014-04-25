class Invitation < ActiveRecord::Base
  belongs_to :inviter, foreign_key: "inviter_id", class_name: "User"

  validates :full_name, presence: true, length: {minimum: 3}
  validates :email, presence: true
  validates :message, presence: true, length: {minimum: 10}

  validate :invitation_is_not_created_for_existing_user

  def invitation_is_not_created_for_existing_user
    if User.all.map(&:email).include?(self.email)
      self.errors.add(:email, "User is already signed up")
    end
  end
end