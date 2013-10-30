class Category < ActiveRecord::Base
  has_many :videos_categories
  has_many :video, through: :videos_categories
  
end