class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def search
    @videos = Video.search_by_title(params[:q])
    binding.pry
    if @videos == []
      redirect_to :back
    else
      render :index
    end
  end

  def show
    @video = Video.find_by id: params[:id]
  end
end
