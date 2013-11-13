class Category < ActiveRecord::Base
  has_many :videos, order: :title

  validates :name, presence: true, uniqueness: true
end