class Invitation < ActiveRecord::Base
  include Tokenable

  belongs_to :user
  has_one :recipient, :class_name => 'User'

  validates_presence_of :fullname, :email, :message, :status
end
