class Video < ActiveRecord::Base
  belongs_to :genre

  validates_presence_of :name, :description
  validates :name, uniqueness: true
  validates :description, presence: true

  def self.search_by_name(name)
    where("name ILIKE ?", "%#{name}%")
  end
end
