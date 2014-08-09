class Video < ActiveRecord::Base
  belongs_to :genre
  has_many :queue_videos
  has_many :reviews, -> { order(created_at: :desc) }

  validates_presence_of :name, :description, :genre_id
  validates :name, uniqueness: true
  validates :description, presence: true

  def self.search_by_name(name)
    where("name ILIKE ?", "%#{name}%")
  end

  def avg_rating
    !!avg ? avg.to_s : "no ratings available"
  end

  private

  def avg
    Review.where(video_id: id).average(:rating)
  end
end
