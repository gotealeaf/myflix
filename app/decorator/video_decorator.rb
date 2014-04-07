class VideoDecorator < Draper::Decorator
  delegate_all

  def rating
    if object.reviews_of_rating > 0
      "#{object.average_rating}/5.0"
    else
      "N/A"
    end
  end
end
