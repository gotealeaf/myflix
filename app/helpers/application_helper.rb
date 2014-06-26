module ApplicationHelper
  # note use of optional parameter, will default to nil if none passed in
  def options_for_video_reviews(selected=nil)
    options_for_select((1..5).map {|number| [pluralize(number, "stars")]}, selected)
  end
end
