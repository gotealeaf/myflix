class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :leader, class_name: 'User'

  validates_presence_of :user, :leader
end
