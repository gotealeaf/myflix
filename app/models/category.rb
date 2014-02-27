class Category < ActiveRecord::Base
	has_many :videos, -> { order('title') } 

  def recent_videos
    self.order(:created_at)
    
  end
end