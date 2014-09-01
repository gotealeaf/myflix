class VideosController < ApplicationController
  before_action :setup_categories, only: [:home, :index]
  before_filter :require_user

  def home
  end

  def index
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
  end

  def search
    search_term = params[:search][:term]
    @results = Video.search_by_title(search_term)
  end

  private

  def setup_categories
    @categories = Category.all
  end

end