class QueueItem < ActiveRecord::Base
	belongs_to :user
	belongs_to :video

	def video_title
		video.title
	end

	def rating
		review = Review.where(video_id: video_id, user_id: user_id).first
		review.rating if review
	end
end