class VideosController < ApplicationController
  before_action :require_user, only: [:show, :search, :create_review]

  def index
    @categories = Category.all
    redirect_to root_path if !logged_in?
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @videos = Video.search_by_title(params[:search_item])
  end

  def create_review
    @video = Video.find(params[:id])
    @review = Review.new(
      rating: params[:rating],
      review_description: params[:review_description],
      video: @video,
      user: current_user
    )
    if @review.save
      render :show
    else
      flash[:error] = "Can not rating twice !!"
      render :show
    end
  end
end
