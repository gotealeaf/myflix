class VideoController < ApplicationController
  before_action :require_user

  def index
  	@categories = Category.all
  end

  def show
  	@video = Video.find(params[:id])
  end

  def searchresults
  	@videoes = Video.search_by_title("#{params[:query]}") 	
  end
end