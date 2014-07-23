class VideosController < ApplicationController
    def index
      # this will be routed to /home/index.html.haml
      @videos = Video.all
    end
end