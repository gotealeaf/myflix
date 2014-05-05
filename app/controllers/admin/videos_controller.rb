class Admin::VideosController < AdminController

  def new
    @video = Video.new
  end
end