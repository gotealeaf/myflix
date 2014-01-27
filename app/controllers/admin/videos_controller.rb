  class Admin::VideosController < ApplicationController
    before_action :require_user
    before_action :require_admin

    def new
      @video = Video.new
    end

    def create
      @video = Video.new(create_video)
      if @video.save
        flash[:success] = "You have added the video #{@video.title}."
      redirect_to new_admin_video_path
    else
      flash[:error] = "Sorry, could not add video, try again later"
      render :new
    end
  end

    private

    def require_admin
      if !current_user.admin?
        flash[:error] = "You do not have access to this page"
      redirect_to home_path unless current_user.admin?
    end
  end 

  def create_video
    params.require(:video).permit!
end 
end