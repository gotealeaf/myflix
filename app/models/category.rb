class Category < ActiveRecord::Base 
  has_many :video_categories
  has_many :videos, order: :title, through: :video_categories
end