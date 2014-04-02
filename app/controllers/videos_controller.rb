class VideosController < ApplicationController
  before_filter :require_signed_in

  def show
    @video = Video.find(params[:id])
  end

  def search
    @results = Video.search_by_title(search_params[:search])
    @searchtext = search_params[:search]
  end

  private
    def search_params
      params.permit(:search)
    end
end
