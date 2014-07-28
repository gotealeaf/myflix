module ApplicationHelper
  def options_for_video_rating(selected=nil)
    options_for_select((1..5).map {|n| [pluralize(n, "Star"), n]}, selected)
  end
end
