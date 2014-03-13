class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :queue_items, -> { order 'position ASC' }
  validates :email, uniqueness: true, presence: true
  validates :fullname, presence: true
end
