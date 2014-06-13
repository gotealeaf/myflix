class Genre < ActiveRecord::Base
  has_many :videos

  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: true

  def to_param
    self.slug
  end
end
