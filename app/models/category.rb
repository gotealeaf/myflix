class Category < ActiveRecord::Base
  has_many :videos

  validates :name, uniqueness: true
end