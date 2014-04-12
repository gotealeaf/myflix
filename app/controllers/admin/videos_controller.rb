class Admin::VideosController < AuthorizationController
  def new
    @video = Video.new
  end

  def create
    categories = (params[:video][:categories]).reject!(&:empty?).map{|cat_id| Category.find(cat_id)}
    @video = Video.new(video_params.merge!(categories: categories))
    if @video.save
      flash[:notice] = "Video successfully added the video #{@video.title}."
      redirect_to new_admin_video_path
    else
      flash[:error] = 'Please fix errors and try again.'
      render 'new'
    end
  end

  def video_params
    params.require(:video).permit(:title, :description, :small_cover, :large_cover, categories: [])
  end
end
