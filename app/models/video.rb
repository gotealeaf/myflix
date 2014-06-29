class Video < ActiveRecord::Base
  belongs_to :genre
  has_many :reviews, -> { order(created_at: :desc) }

  validates_presence_of :name, :description
  validates :name, uniqueness: true
  validates :description, presence: true

  def self.search_by_name(name)
    where("name ILIKE ?", "%#{name}%")
  end

  def avg_rating
    "no ratings yet"
  end
end
