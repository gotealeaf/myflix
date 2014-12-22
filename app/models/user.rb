class User < ActiveRecord::Base
  has_secure_password validation: false
  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates_uniqueness_of :email, on: :create
end