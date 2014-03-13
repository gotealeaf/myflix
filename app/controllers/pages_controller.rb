class PagesController < ApplicationController
  layout "application"

  def front
    redirect_to home_path if current_user
  end
end
