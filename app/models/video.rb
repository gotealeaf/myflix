class Video < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true

  def self.search_by_title(search_term)
    if search_term.blank? #use blank instead of empty bc empty includes "  "
      return []
    else
      where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
    end
  end
end
