class VideoController < ApplicationController

  def show
    @video = Video.find(params[:id])
  end

end