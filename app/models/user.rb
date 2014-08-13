class User < ActiveRecord::Base
  validates :email, presence: true
  validates :full_name, presence: true
  validates :password, presence: true
end
