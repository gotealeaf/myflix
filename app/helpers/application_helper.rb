module ApplicationHelper


  def options_for_video_rating(selected)
    options_for_select((1..5).to_a.reverse.map {|n| [pluralize(n, "Star"), n]}, selected )
  end

  def already_queued?(video)
    current_user.queue_items.map(&:video).include?(video)
  end


  def page_title(title_string)
  content_for(:title) { title_string }
  end
end