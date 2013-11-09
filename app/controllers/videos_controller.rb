class VideosController < ApplicationController
  before_filter :require_user

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])

  end

  def search
    @categories = Category.all
    @videos = Video.search_by_title(params[:search_term])
  end

  private
    def video_params
      params.require(:video).permit(:title, :description, :small_cover_url, :large_cover_url)
    end


end