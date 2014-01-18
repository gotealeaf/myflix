class Review < ActiveRecord::Base
  validates_presence_of :body, :rating

  belongs_to :video
  belongs_to :user

end