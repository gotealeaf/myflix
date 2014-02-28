class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, -> { distinct }, through: :video_categories

  validates :name, presence: true, uniqueness: true
end
