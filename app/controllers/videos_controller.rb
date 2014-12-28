class VideosController < ApplicationController

  def index		
    redirect_to root_path unless logged_in?
  end

  def show
  	@video = Video.find(params[:id])
  end

  def search
    @results = Video.search(params[:query])

  end

  
end