class Category < ActiveRecord::Base
  has_many :videos, -> { order 'title' }

  validates :name, uniqueness: true
end