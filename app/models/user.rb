class User < ActiveRecord::Base

  has_many :reviews
  has_many :queue_items

  has_secure_password validation: false
  validates_presence_of :email, :full_name
  validates_presence_of :password, :password_confirmation, on: :create
  validates_length_of :password, :password_confirmation,
                      minimum: 5, on: :create, too_short: 'please enter at least 6 characters'
  validates :email, uniqueness: true #format
end
