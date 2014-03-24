class Rating < ActiveRecord::Base
  belongs_to :review
  belongs_to :creator, foreign_key: :user_id, class_name: :User
end