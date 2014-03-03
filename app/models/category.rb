class Category < ActiveRecord::Base
  #has_many :videos, order: :title #from examples, now deprecated
  has_many :videos, -> { order "title" }
end