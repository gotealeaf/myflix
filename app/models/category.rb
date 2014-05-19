class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :videos, through: :categorizations
end
