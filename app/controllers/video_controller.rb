class VideoController < ApplicationController

  def index
  	@video = Video.find_by(title: 'futurama')
  end
end
