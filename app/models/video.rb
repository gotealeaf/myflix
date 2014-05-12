class Video < ActiveRecord::Base
  belongs_to :category

  validates_uniqueness_of :title
end