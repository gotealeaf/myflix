class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order(created_at: :desc) }
  has_many :queue_items
  has_many :users, through: :queue_items

  validates :title, presence: true
  validates :description, presence: true

  def self.search_by_title(term)
    return [] if term.blank?
    where("title LIKE ?", "%#{term}%").order('created_at')
  end
end