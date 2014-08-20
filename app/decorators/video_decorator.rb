class VideoDecorator

  attr_reader :video

  def initialize(video)
    @video = video
  end

  def avg_rating
    !!avg ? "#{avg}/5.0" : "no ratings available"
  end

  private

  def avg
    Review.where(video_id: video.id).average(:rating)
  end
end
