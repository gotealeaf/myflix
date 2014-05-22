class Invitation < ActiveRecord::Base
  include Tokenable
  validates_presence_of :recipient_email, :recipient_name, :message
  belongs_to :inviter, class_name: "User"
  
  #before_create :generate_token
  
  #def generate_token
    #self.token = SecureRandom.urlsafe_base64
  #end
  
end