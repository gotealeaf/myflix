class Friend < ActiveRecord::Base

  include Tokenable
  
  belongs_to :user

  validates_presence_of :full_name, :email, :message, :user_id
end