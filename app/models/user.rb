class User < ActiveRecord::Base
  has_secure_password validation: false

  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :email, presence: true, uniqueness: true,  on: :create
  
end