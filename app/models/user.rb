class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: :true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :full_name, presence: true

  has_many :reviews,  -> { order(created_at: :desc) }
  has_many :queue_items
  has_many :videos, through: :queue_items

  has_secure_password
end