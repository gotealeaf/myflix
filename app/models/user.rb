class User < ActiveRecord::Base
  has_many :reviews
  has_many :my_queues

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password 
end