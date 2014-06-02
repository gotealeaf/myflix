class Category < ActiveRecord::Base
  has_many :videos, -> { where order: :title} 
  # order: :title 
end