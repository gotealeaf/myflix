class Video < ActiveRecord::Base
  belongs_to :category, foreign_key: :category_id

  validates :title, uniqueness: true
end