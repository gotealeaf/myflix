class Review < ActiveRecord::Base
  validates_presence_of :body, :rating
  validates_uniqueness_of :user, scope: :video

  belongs_to :video
  belongs_to :user

end