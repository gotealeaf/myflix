class Review < ActiveRecord::Base
  
  belongs_to :video
  belongs_to :reviewer, foreign_key: 'user_id', class_name: 'User'
  
  validates_presence_of :content, :rating
  
  end