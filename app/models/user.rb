class User < ActiveRecord::Base
  validates :email, presence: :true, uniqueness: :true
  validates :password, presence: :true, on: :create, length: {minimum: 3}
  validates_presence_of :name

  has_secure_password validations: false
end