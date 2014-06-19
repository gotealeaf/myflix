class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  
  validates_presence_of :user, :video
end