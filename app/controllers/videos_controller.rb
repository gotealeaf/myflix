class VideosController < ApplicationController

  before_action :require_user

  def index
    @genres = Genre.all
  end

  def show
    @video = Video.find(params[:id])
    @review = Review.new
    @reviews = @video.reviews
  end

  def search
    @results = Video.search_by_name(params[:search_name])
  end
end
