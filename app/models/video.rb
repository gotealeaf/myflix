class Video < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title, :description

  def self.search_by_title(key_word)
    return [] if key_word.blank?
    where("title LIKE ?", "%#{key_word}%").order("created_at DESC")
  end
end