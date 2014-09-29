class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order("created_at DESC")}
  has_many :queue_items

  validates :title, presence: true
  validates :description, presence: true

  def in_my_queue?(current_user)
    QueueItem.where(video_id: id, user_id: current_user.id).first.present?
  end

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
