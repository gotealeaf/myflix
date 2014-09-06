class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password_digest, presence: true
  has_many :reviews
  has_many :queue_items, -> { order(:position)}

  has_secure_password
end
