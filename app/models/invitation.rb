class Invitation < ActiveRecord::Base
  include Tokenable
  belongs_to :inviter, foreign_key: 'inviter_id', class_name: 'User'

  validates_presence_of :recipient_name, :recipient_email, :message
  validates_uniqueness_of :recipient_email
end
