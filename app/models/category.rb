class Category < ActiveRecord::Base
  has_many :videos, as: :videos

  validates_uniqueness_of :name
end
