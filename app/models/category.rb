class Category < ActiveRecord::Base
	has_many :videos, -> { order(created_at: :desc) }

	def recent_videos
		return [] if videos.size == 0
		videos.first(6)
	end
end