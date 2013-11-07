class VideosController < ApplicationController

  def index
    @videos = Video.all
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])

  end

  def search
    @categories = Category.all
    @videos = Video.search_by_title(params[:search_term])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def video_params
      params.require(:video).permit(:title, :description, :small_cover_url, :large_cover_url)
    end


end