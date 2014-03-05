module ApplicationHelper

  def show_rating(qi)
    if qi.video.review.blank?
      "No rating"
    else
      self.video.rating
    end
  end

end
