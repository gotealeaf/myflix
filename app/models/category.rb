class Category < ActiveRecord::Base
  has_many :videos

  validates_uniquness_of :name
end