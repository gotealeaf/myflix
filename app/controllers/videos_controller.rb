class VideosController < ApplicationController
  layout "application"

  def home; end

  def search
    @videos = Video.search_by_title(params[:search])
  end
end