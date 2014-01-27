class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews

  validates_presence_of :title, :description

  def self.search_by_title(title)
    return [] if title.blank?

    self.where('lower(title) LIKE :search_string', search_string: '%' + title.to_s.downcase + '%').
        order(created_at: :desc)
  end
end
