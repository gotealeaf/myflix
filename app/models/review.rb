class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  
  validates_uniqueness_of :content
  validates_presence_of :rating, :content 
end
