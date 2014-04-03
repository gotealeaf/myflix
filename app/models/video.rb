class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order(created_at: :desc) }

  validates :title, presence: true
  validates :description, presence: true
  validates :category, presence: true

  def self.search_by_title(term)
    return [] if term.blank?
    where("title LIKE ?", "%#{term}%").order('created_at')
  end
end