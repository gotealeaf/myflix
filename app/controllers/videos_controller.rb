class VideosController < ApplicationController

  before_action :set_video, except: [:index, :new, :search]
  before_action :require_user

  def index
    @genres = Genre.all
  end

  def show
    @review = Review.new
    @reviews = @video.reviews
  end

  def search
    @results = Video.search_by_name(params[:search_name])
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
end
