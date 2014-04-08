class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User", foreign_key: "follower_id"
  belongs_to :leader, class_name: "User", foreign_key: "leader_id"
end
