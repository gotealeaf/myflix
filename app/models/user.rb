class User < ActiveRecord::Base
	has_secure_password validations: false
	validates_presence_of :email, :password, :fullname
	validates_uniqueness_of :email
	has_many :reviews
	has_many :queue_items
end