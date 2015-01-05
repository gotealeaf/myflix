class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates :body, presence: true
end