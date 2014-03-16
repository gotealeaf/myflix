class VideosController < ApplicationController
  before_filter :user_required!

  def index
    @category_videos = {}
    Category.all.each do |category|
      @category_videos.merge!(category => category.recent_videos)
    end
  end

  def show
    @video   = Video.find(params[:id])
    @reviews = @video.reviews
    @new_review = Review.new
    @rating  = @reviews.any? ? @reviews.average(:rating).round(1) : 0
  end

  def search
    @videos = Video.search_by_title(params[:q])
  end
end
