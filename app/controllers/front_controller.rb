class FrontController < ApplicationController
  def index
    redirect_to 'videos#index' if logged_in?    
  end
end
