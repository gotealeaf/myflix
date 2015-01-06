class VideosController < ApplicationController
before_action :require_user

  def index		    
    @categories = Category.all

  end

  def show
  	@video = Video.find(params[:id])
    @review = Review.new
  end

  def search
    @results = Video.search(params[:query])

  end

end