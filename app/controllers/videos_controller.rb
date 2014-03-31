class VideosController < ApplicationController
  before_action :require_user

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @user = User.find(session[:user_id])
    @reviews = @video.reviews
    if @reviews.count > 0
      @avg_rating = @reviews.average(:rating).round(1)
    else
      @avg_rating = 3
    end
    @review = Review.new
  end

  def search
    @results = Video.search_by_title(params[:search_term])
  end
end