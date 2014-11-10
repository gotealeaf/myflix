class Invitation < ActiveRecord::Base
  
  include Tokenable
  belongs_to :user
  validates_presence_of :friend_email
  
end