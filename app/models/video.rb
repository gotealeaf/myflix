class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, -> { order name }, through: :video_categories

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.empty?
    where('title LIKE ?', "%#{search_term}%").sort_by { |video| video.created_at }.reverse
  end
end