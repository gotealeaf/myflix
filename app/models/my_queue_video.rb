class MyQueueVideo < ActiveRecord::Base
  belongs_to :video
  belongs_to :my_queue
end