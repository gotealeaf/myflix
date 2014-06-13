class Video < ActiveRecord::Base
  # title: string
  # description : text
  # small_cover_url : string
  # large_cover_url : string
  
  validates :title, presence: true
  validates :description, presence: true
  
  belongs_to :category
end
