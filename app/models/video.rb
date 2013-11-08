class Video < ActiveRecord::Base
  belongs_to :category, foreign_key: :category_id

  validates_presence_of :title, :description
  validates_uniqueness_of :title

  def self.search_by_title(search_term)
    where('title LIKE ?', '%#{search_term}%')
  end
end