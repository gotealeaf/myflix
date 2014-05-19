class Video < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, through: :categorizations

  scope :comedy, -> { joins(:categories).where('categories.name = ?', "Comedy")}
  scope :dramas, -> { joins(:categories).where('categories.name = ?', "Drama")}
  scope :action, -> { joins(:categories).where('categories.name = ?', "Action")}
end
