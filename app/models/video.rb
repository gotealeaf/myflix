class Video < ActiveRecord::Base
  belongs_to :genre
  has_many :queue_videos
  has_many :reviews, -> { order(created_at: :desc) }

  validates_presence_of :name, :description, :genre_id
  validates :name, uniqueness: true
  validates :description, presence: true

  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  def self.search_by_name(name)
    where("name ILIKE ?", "%#{name}%")
  end
end
