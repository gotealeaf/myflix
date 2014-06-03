class Relationship < ActiveRecord::Base
  belongs_to :leader, class_name: "User" #because both are from the User model. Relationship is a join table. Leader is a user
  belongs_to :follower, class_name: "User" # follower is also a user
end