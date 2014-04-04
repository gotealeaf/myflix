class Invitation < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :fullname, :email, :message, :status
end
