  class Video < ActiveRecord::Base
	has_many :video_categories
	has_many :categories, through: :video_categories

  validates :title, presence: true
  validates :description, presence: true, length: {minimum: 5}
end