class Review < ActiveRecord::Base
  belongs_to :creator, foreign_key: "user_id", class_name: "User"
  belongs_to :video

  validates :body, presence: true, length: { minimum: 10 }
  validates :rating, presence: true
end