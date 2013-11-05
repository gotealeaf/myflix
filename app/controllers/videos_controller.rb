class VideosController < ApplicationController

  def show
    @video = Video.find(params[:id])
    render 'ui/video'
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :small_cover_url, :large_cover_url, :category_id)
  end
end