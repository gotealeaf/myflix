class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates :content, presence: true
end
