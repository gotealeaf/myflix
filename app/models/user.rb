class User < ActiveRecord::Base
  has_secure_password validations:false
  validates_presence_of [:email, :name, :password]
  validates_uniqueness_of :email
  validates :password,
    on: :create,
    length: { minimum: 5 }
end