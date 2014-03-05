class User < ActiveRecord::Base

  has_secure_password validations: false
  validates :full_name, presence: true, length: {minimum: 3}
  validates :email, presence: true, uniqueness: true, length: {minimum: 6}
  validates :password, presence: true, length: {minimum: 5}
end