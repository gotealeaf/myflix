class User < ActiveRecord::Base
  has_secure_password validations: false
  validates :password, on: :create, length: { minimum: 8 }, confirmation: true
  validates_presence_of :full_name, :email, :password, :password_confirmation
  validates_uniqueness_of :email

end
