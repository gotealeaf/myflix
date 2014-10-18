class UiController < ApplicationController
  before_filter do
    redirect_to :root if Rails.env.production?
  end

  layout "application"

  def index

  end

  def home
  	@videos = Video.all
  end

  def genre
  	@category = Category.all
  end

  def searchresults
  	@videoes = Video.search_by_title("#{params[:query]}")
  	
  end

end
