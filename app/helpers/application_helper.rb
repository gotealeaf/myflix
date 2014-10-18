module ApplicationHelper
	def average_rating(video)
			sum = 0
		video.reviews.each do |video|
			sum += video.rating
		end
		return (sum.to_f / video.reviews.size ).round(1)
	end
end
