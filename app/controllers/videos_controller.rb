class VideosController < ApplicationController

  def index
    @videos = Video.all
  end

  def show
    #binding.pry
    @video = Video.find(params[:id])

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