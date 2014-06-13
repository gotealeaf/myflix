class Video < ActiveRecord::Base
  belongs_to :genre

  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: true

  def to_param
    self.slug
  end
end
