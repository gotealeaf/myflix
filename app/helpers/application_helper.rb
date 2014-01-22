module ApplicationHelper


  def options_for_video_rating(selected)
    options_for_select((1..5).to_a.reverse.map {|n| [pluralize(n, "Star"), n]}, selected )
  
  end
end
