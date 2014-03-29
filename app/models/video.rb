class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, through: :video_categories, order: :name

  #Validations
  validates :title,       presence: true#,
                          #length: { maximum: 30 }
  validates :description, presence: true

  def self.search_by_title(search_string)
    Video.where(["title LIKE ?", "%#{search_string}%"])
  end
end
