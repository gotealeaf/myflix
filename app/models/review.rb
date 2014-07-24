class Review < ActiveRecord::Base
  belongs_to :creator, class_name: User, foreign_key: :user_id
  belongs_to :video
  
end
