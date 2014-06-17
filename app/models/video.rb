class Video < ActiveRecord::Base
  belongs_to :genre

  validates_presence_of :name, :description
  validates :name, uniqueness: true
  validates :description, presence: true

  #validates :slug, uniqueness: true

  def to_param
    self.slug
  end
end
