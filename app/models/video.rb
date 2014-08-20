class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> {order("created_at DESC")}

  validates_presence_of :title
  validates_presence_of :description


  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end
end