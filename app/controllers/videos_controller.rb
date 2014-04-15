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

end
