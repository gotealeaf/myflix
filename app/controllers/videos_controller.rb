class VideosController < ApplicationController
  before_filter :require_user

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @review = Review.new
  end

  def search
    @videos_searched = Video.search_by_title(params[:search_term])
  end

end