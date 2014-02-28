class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories,  -> { distinct }, through: :video_categories
end
