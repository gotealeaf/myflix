class PagesController < ApplicationController

  def front  # for landing page or front page
    redirect_to home_path if current_user             
  end
end
