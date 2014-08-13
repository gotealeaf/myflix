class PagesController < ApplicationController
  def front
    if current_user
      redirect_to home_path
    end
  end
end
