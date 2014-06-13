class Category < ActiveRecord::Base
  # name : string
  has_many :videos, -> { order :title }
end
