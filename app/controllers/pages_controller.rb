class PagesController < ApplicationController  
  def front
    if logged_in?
      @categories = Category.all
      render 'videos/index'
    end
  end
end