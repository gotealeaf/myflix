class Admin::VideosController < AdminsController
  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:notice] = "Success! Video created."
      redirect_to new_admin_video_path
    else
      render :new
    end 
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :category, :large_cover, :small_cover, :video_url)
  end
end