module ApplicationHelper
  def options_for_video_review(selected=nil)
    options_for_select((1..5).map {|n| [pluralize(n, "Star"), n]}, selected)
  end

  def average_video_rating(video)
    if video.reviews.blank?
      "-"
    else
      video.reviews.map(&:rating).inject(0,:+)/video.reviews.count.to_f
    end
  end
end
