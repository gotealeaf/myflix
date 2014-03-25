class User < ActiveRecord::Base
  has_many :reviews, -> { order("created_at DESC")}
  has_many :queue_items, -> { order("position ASC, created_at DESC")}

  has_secure_password validations: false

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, length: { minimum: 5 }, on: :create
end