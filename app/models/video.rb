class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews

  validates :title, presence: true
  validates :description, presence: true

  def self.recent_videos
    #sort in reverse order
    found_videos = Video.last(6).sort{|b,a| a.created_at <=> b.created_at}
  end

  def self.search_by_title(search_term)
    if search_term.blank?
      []
    else
      where(["title LIKE ?", "%#{search_term}%"] ).order("created_at")
    end
  end

end
