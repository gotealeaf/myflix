class Genre < ActiveRecord::Base
  has_many :videos, ->{order(:name)}

  validates :name, presence: true, uniqueness: true

  #validates :slug, uniqueness: true

  def to_param
    self.slug
  end
end
