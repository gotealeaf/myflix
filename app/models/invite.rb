class Invite < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :friend_name, :friend_email
end