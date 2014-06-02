class UiController < ApplicationController
  before_filter do
    redirect_to :root if Rails.env.production?
  end

  layout "application"

  def index
  end

  def video
    @video = Video.find(3)
  end

  def genre
    @category = Category.find(2)
    @videos = @category.videos
  end

end
