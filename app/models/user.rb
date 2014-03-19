class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items

  validates :full_name, presence: true, length: {minimum: 3}
  validates :email, presence: true, uniqueness: true, length: {minimum: 6}
  validates :password, presence: true, on: :create, length: {minimum: 5}

  has_secure_password validations: false
end