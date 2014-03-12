class PagesController < ApplicationController
  def front
    redirect_to videos_path if signed_in?
  end
end