class User < ActiveRecord::Base
  has_secure_password validations: false
  validates_presence_of :email, :password, :name
  validates_uniqueness_of :email
  has_many :reviews
end
