class UiController < ApplicationController
  before_filter do
    redirect_to :root if Rails.env.production?
  end

  layout "application"

  def index
  end

  def home
    @videos = Video.all
    @categories = Category.all
  end   

  def video
    @video = Video.first
  end

  def genre
    @category = Category.find(params[:id])
  end

end
