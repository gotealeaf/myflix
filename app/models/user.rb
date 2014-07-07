class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  has_many :reviews

  # validates :email, presence: true, uniqueness: true
  # validates :password, presence: true, :length => ( :minimum => 4), on: :create
  # validates :password, allow_blank: true, :length => ( :minimum => 4), on: :update
  # validates :full_name, presence: true

  has_secure_password validations: false
end