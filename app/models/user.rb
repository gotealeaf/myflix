class User < ActiveRecord::Base
  
  has_secure_password validations: false
  
  has_many :reviews
  
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :full_name, presence: true
  
end