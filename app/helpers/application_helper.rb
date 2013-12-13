module ApplicationHelper
<<<<<<< HEAD
=======
  def options_for_video_reviews(selected=nil)
    options_for_select([5,4,3,2,1].map {|number| [pluralize(number, "Star")]},selected)
  end
>>>>>>> mod6
end
