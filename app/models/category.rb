class Category < ActiveRecord::Base
  has_many :videos, order: :title
  validates_presence_of :title, :description

end
