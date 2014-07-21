class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :email, :full_name
  validates_presence_of :password, :password_confirmation, on: [:create, :update]
  validates_length_of :password, :password_confirmation,
                      minimum: 5, on: [:create, :update],
                      too_short: 'please enter at least 6 characters'
  validates :email, uniqueness: true #format
end
