class Category < ActiveRecord::Base
  has_many :videos, -> { order 'title asc' }
end
