class Video < ActiveRecord::Base
  # title: string
  # description : text
  # small_cover_url : string
  # large_cover_url : string

  validates :title, presence: true
  validates :description, presence: true

  belongs_to :category
  has_many :reviews

  def average_rating
    Review.average_rating_for_video(self)
  end

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    Video.where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end
end
