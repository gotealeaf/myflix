class Video < ActiveRecord::Base
  belongs_to :genre
  has_many :reviews

  validates_presence_of :name, :description
  validates :name, uniqueness: true
  validates :description, presence: true

  def self.search_by_name(name)
    where("name ILIKE ?", "%#{name}%")
  end
end
