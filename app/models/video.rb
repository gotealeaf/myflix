class Video < ActiveRecord::Base
  # title: string
  # description : text
  # small_cover_url : string
  # large_cover_url : string
  
  belongs_to :category
end
