class Invitation < ActiveRecord::Base
  before_save :generate_token!

  belongs_to :inviter, class_name: "User"
  validates_presence_of :recipient_email, :recipient_name, :message, :inviter_id


  private

    def generate_token!
      self.token = SecureRandom.urlsafe_base64
    end
end
