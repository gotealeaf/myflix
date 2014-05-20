class User < ActiveRecord::Base
  has_secure_password
  has_secure_password validations: false
  has_many :queue_items
  
  validates_presence_of :full_name, :email
  validates_uniqueness_of :email

  
end
