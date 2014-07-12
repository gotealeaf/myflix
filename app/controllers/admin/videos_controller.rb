class Admin::VideosController < ApplicationController
  before_filter :require_user 
  before_filter :ensure_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "You have successfully added the video #{@video.title}"
      redirect_to new_admin_video_path
    else
      flash[:error] = "You need to fill all the required fields please."
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :category_id, :description, :large_cover, :small_cover, :video_url)
  end

  def ensure_admin
    if !current_user.admin?
      flash[:error] = "You are not allowed to visit this area."
      redirect_to root_path
    end
  end
end