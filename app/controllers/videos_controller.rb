class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :require_user
  
  def index
    @categories = Category.all
  end
  
  def show
  end
  
  def search
    @videos = Video.search_by_title(params[:search_term])
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :description, :small_cover_url, :large_cover_url)
    end
  
end
