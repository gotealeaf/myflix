class Admin::VideosController < AdminsController

  
  def new
      @video = Video.new
  end
  
  def create
  end
  
end