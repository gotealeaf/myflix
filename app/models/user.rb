class User < ActiveRecord::Base
  has_secure_password validation: false
  has_many :reviews
  has_many :my_queue_videos

  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :email, presence: true, uniqueness: true,  on: :create
  
end