module ApplicationHelper

  def options_for_video_rating(rating=nil)
    options_for_select([1,2,3,4,5].map{|i| [ pluralize(i,'Star'),i]}, rating)
  end
end
