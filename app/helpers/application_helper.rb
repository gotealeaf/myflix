module ApplicationHelper
  
  def options_for_video_review(selected=nil)
    options_for_select([5, 4, 3, 2, 1].map { |number| [pluralize(number, "Star"), number] }, selected)
  end
  
end
