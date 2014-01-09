class User < ActiveRecord::Base
  validates_presence_of :email, :full_name
  validates_uniqueness_of :email

  has_secure_password
end