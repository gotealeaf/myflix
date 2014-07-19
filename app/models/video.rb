class Video < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title, :description, :large_cover_image_url, :small_cover_image_url, :category_id

end
