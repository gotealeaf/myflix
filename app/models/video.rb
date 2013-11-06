class Video < ActiveRecord::Base
  belongs_to :category, foreign_key: :category_id

  validates_presence_of :title, :description
  validates :title, uniqueness: true
end