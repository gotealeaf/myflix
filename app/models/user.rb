class User < ActiveRecord::Base
  
  has_secure_password validations: false
  has_many :queue_items
  validates :email, presence: true
  validates :full_name, presence: true
  validates :password, presence: true, on: :create
end