class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :rating, presence: true
  validates :review_text, presence: true, length: { minimum: 50 }
end