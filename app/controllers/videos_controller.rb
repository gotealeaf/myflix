class VideosController < ApplicationController
  layout "application"

  def home; end

  # def show; end

  def search
    @results = Video.search_by_title(params[:search_term])
  end
end