class VideosController < ApplicationController
  before_action :require_user

  def search
    @results = Video.search_by_title(params[:search_term])
  end

  def show
    @video = Video.find(params[:id])
  end
end