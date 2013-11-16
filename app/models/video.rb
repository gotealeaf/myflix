class Video < ActiveRecord::Base
  belongs_to :category, foreign_key: :category_id
  has_many :reviews, -> { order 'created_at DESC' }

  validates_presence_of :title, :description
  validates_uniqueness_of :title

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where('title LIKE ?', "%#{search_term}%").order('created_at DESC')
  end
end