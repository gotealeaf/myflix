class User < ActiveRecord::Base
  has_secure_password validations: false

  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 5 }
  validates :email, presence: true, uniqueness: true
end