class PagesController < ApplicationController
  def front
    if logged_in?
      redirect_to home_path
    end
  end
end