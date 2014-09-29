module ApplicationHelper

  def options_for_video_reviews marked=nil
    options_for_select((1..5).map{ |u| [pluralize(u, " Star"), u] }, marked)
  end

end
