class Review < ActiveRecord::Base
  validates_presence_of :body, :rating
  validates_uniqueness_of :user, scope: :video
  validates_numericality_of :rating, {greater_than: 0}

  belongs_to :video
  belongs_to :user

end