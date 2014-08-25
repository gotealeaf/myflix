class VideosController < ApplicationController
  before_action :setup_categories, only: [:home, :index]
  before_action :set_video, only: [:show]
  before_filter :require_user

  def home
  end

  def index
  end

  def show
  end

  def search
    search_term = params[:video][:search_term]
    @results = Video.search_by_title(search_term)
  end

  private

  def setup_categories
    @categories = Category.all
  end

  def set_video
    @video = Video.find(params[:id])
  end
end