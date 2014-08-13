class Admin::VideosController < AdminsController
  def new
    @video = Video.new
  end

  def create
    video = Video.new(video_params)
    if video.save
      flash[:notice] = "Success! Video created."
      redirect_to home_path
    else
      render :new
    end 
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :category, :large_cover_url, :small_cover_url)
  end
end