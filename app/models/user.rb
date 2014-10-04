class User < ActiveRecord::Base
	has_secure_password
	validates_presence_of :email, :password, :fullname
	validates_uniqueness_of :email
end