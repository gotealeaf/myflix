class Admin::VideosController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:info] = "You have successfully add video #{@video.title}"
      redirect_to new_admin_video_path
    else
      flash[:danger] = "You can not add this video. Please check your input."
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit(:title,:category_id,:description,:large_cover,:small_cover,:video_url)
  end
end
