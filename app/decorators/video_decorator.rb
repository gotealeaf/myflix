class VideoDecorator < Draper::Decorator
  delegate_all
  
  def rating
    object.rating.present? ? "#{object.rating} / 5.0" : "Not applicable" #this checks against the model
  end
end