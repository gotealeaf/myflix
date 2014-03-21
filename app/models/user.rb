class User < ActiveRecord::Base
  validates :email, presence: true
  validates :password, presence: true, on: :create
  validates :full_name, presence: true

  has_secure_password
end