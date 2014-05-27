class User < ActiveRecord::Base

has_secure_password validations: false

has_many :reviews
has_many :queue_items

validates_presence_of :email, :password, :full_name
validates_uniqueness_of :email

end
