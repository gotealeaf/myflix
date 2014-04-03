class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order("position") }

  has_secure_password validations: false

  validates :name, presence: true,
                   length: { minimum: 1, maximum: 30 }

  validates :email, presence: true,
                    uniqueness: true#,
                    #length: { minimum: 6, maximum: 50 }

  validates :password, presence: true,
                       length: { minimum: 6 }
end
