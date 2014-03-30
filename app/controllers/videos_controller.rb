class VideosController < ApplicationController
  before_action :require_user

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews   
    @avg_rating = @reviews.average(:rating)
    @review = Review.new(video: @video)
  end

  def search
    @results = Video.search_by_title(params[:search_term])
  end
end