class User < ActiveRecord::Base
  has_secure_password validations: false
  validates_presence_of :full_name, :email, :password
  validates_uniqueness_of :email, :slug
  validates :password, on: :create, length: { minimum: 8 }
end
