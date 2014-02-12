class User < ActiveRecord::Base
  has_secure_password validations: false
  validates :email, uniqueness: true, presence: true
  validates :fullname, presence: true
end
