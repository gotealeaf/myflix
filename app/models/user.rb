class User < ActiveRecord::Base
  has_many :queue_items
  has_secure_password validations: false
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :full_name, presence: true
end
