class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, through: :video_categories, order: :title

  # Validations
  validates :name, presence: true#,
                   #length: { maximum: 30 }

end
