class VideosController < ApplicationController
  before_filter :authorize
  before_filter :find_video, only: [:show]

  def index
    @categories = Category.all
  end

  def show
    @reviews = @video.reviews
    @new_review = Review.new()
  end

  def search
    @search_term = params[:search_term]
    @videos = Video.search_by_title(@search_term)
  end

  private

  def find_video
    @video = Video.find(params[:id])
  end
end