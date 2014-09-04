class VideosController < ApplicationController

def index
end

def show
@video=Video.find(params[:id])
end

end