class Video < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true

  def self.search_by_title(title)
    where('title LIKE ?', "%#{title}%").order(:title)
  end
end
