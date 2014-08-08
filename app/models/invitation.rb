class Invitation < ActiveRecord::Base
  include Tokenify

  belongs_to :inviter, class_name: "User"
  validates_presence_of :recipient_email, :recipient_name, :message, :inviter_id

end
