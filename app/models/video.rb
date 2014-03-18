class Video < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true

  def self.search_by_title(term)
    Video.find_by_sql("SELECT * FROM videos WHERE title LIKE '%#{term}%'")
  end
end