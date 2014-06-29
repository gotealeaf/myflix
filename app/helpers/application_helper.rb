module ApplicationHelper
  def options_for_video_reviews(selected=nil)
    options_for_select((1..5).map {|number| [pluralize(number, "Star"), number]}, selected)
  end
end
