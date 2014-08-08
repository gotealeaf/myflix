class PagesController < ApplicationController
  def welcome
    redirect_to videos_path if signed_in? 
  end

end
