class PagesController < ApplicationController  
  def front
    redirect_to videos_path if current_user
  end

end 