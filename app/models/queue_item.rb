class QueueItem < ActiveRecord::Base
	belongs_to :user
	belongs_to :video

	delegate :name, to: :category, prefix:true
	delegate :title, to: :video, prefix:true



	def rating
		review = Review.where(user_id: user.id, video_id: video.id).first
		review.rating if !review.blank?
	end


	def category
		video.category
	end
end