class VideoDecorator < Draper::Decorator
  delegate_all
  
  def rating
    object.average_rating.present? ? "#{@video.average_rating} / 5.0" : "Not applicable" #this checks against the model
  end
end