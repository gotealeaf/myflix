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
      flash[:error] = "Please fix the problems below."
      render :new
    end 
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :category_id, :large_cover, :small_cover, :video_url,)
  end
end