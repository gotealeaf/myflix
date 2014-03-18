module ApplicationHelper

  def show_rating(qi)
    if qi.video.review.blank?
      "No rating"
    else
      self.video.rating
    end
  end

  def options_for_video_reviews(selected=nil)
    options_for_select((1..5).map { |num| [pluralize(num, "star") , num]}, selected)
  end

  def video_review_rating_from_user(current_user, qi)
    if current_user.reviews.where(video_id: "#{qi.video_id}").first != nil
      current_user.reviews.where(video_id: "#{qi.video_id}").first.rating
    end
  end

end
