class Category < ActiveRecord::Base
  # name : string
  has_many :videos
end
