class Invitation < ActiveRecord::Base
  validates :inviter, presence: true
  validates :invitee_email, presence: true
  validates :invitee_name, presence: true
  validates :message, presence: true
  validate :invitation_cannot_have_registered_invitee

  belongs_to :inviter, class_name: :User, foreign_key: :inviter_id

  private

  def invitation_cannot_have_registered_invitee
    errors.add(:invitee_email, "This email is already registered.") if User.find_by_email(invitee_email)
  end
end