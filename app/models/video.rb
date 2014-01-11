class Video < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :title, :description

  def self.search_by_title(search_string)
    return [] if search_string.blank?
    where('title LIKE ?', "%#{search_string}%").order("created_at DESC")
  end
end