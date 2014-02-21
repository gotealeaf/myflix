module ApplicationHelper
	def options_for_video_reviews
		options_for_select((1..5).map {|num| [pluralize(num, "Star"), num]}, selected)
	end
end
