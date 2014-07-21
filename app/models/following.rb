class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :followee, class_name: "User"
end
