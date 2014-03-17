class User < ActiveRecord::Base
  has_secure_password validations: false
  validates_presence_of :email, :full_name  
  validates_uniqueness_of :email
end