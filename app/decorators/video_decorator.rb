class VideoDecorator < Draper::Decorator
  delegate_all

  def average_rating
    object.average_rating.present? ? "#{object.average_rating}" : "N/A"
  end
end