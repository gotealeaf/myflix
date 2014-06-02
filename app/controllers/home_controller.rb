class HomeController < ApplicationController
  def index
    @videos = Video.all
  end
end
