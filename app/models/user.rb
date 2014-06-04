class User < ActiveRecord::Base
  has_secure_password validations: false

  validates :full_name, presence: true  
  validates :email, presence: true  
#  validates :password, presence: true  

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end
end
