class Video < ActiveRecord::Base
  belongs_to :category

  default_scope { order("created_at") }

  validates_presence_of :title, :description

  def self.search_by_title(keyword)
    return [] if keyword.blank?
    where("title LIKE ?", "%#{keyword}%")
  end
end
