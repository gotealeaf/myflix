class Video < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title, :description, :large_cover_image_url, :small_cover_image_url, :category_id


  def self.search_by_title(search_item)
    return [] if search_item.blank?
    where("title LIKE ?", "%#{search_item}%").order("created_at DESC")
  end
end
