class UiController < ApplicationController
  before_filter do
    redirect_to :root if Rails.env.production?
  end

  layout "application"

  def index
  end

  def home
    @categories = Category.all
  end

  def video
    @video = Video.first   # find(params[:id])
  end
end
