class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end


  def search

    @results = search_by_title(params[:search_term])

  end
        
  def edit
  end

  def new
  end

  private

  def search_by_title(search_term)
    @nada = [Video.first, Video.last]
      
  end

end
