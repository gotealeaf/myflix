class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def search
    binding.pry
    @videos = Video.search_by_title(params[:search_term])
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
