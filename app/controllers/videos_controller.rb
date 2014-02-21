class VideosController < ApplicationController
  before_action :require_user, :find_user

  def index
    @videos = Video.all
    @category = Category.all
  end

  def search
    @videos = Video.search_by_title(params[:q])
    if @videos == []
      redirect_to :back
    else
      render :search
    end
  end

  def show
    @video = Video.find_by id: params[:id]
    @reviews = @video.reviews
    @review = Review.new
    session[:video_id] = params[:id]
  end

  private

  def find_user
    @user = User.find(session[:user_id])
  end
end
