class VideoDecorator < Draper::Decorator
  delegate_all

  def rating
    if object.average_rating == 0.0
      "No Reviewer Ratings"
    else
      "#{object.average_rating} / 5.0"
    end
  end

end
