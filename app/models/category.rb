class Category < ActiveRecord::Base
  has_many :videos

  validates_uniqueness_of :name
end