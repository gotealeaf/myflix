class SessionsController < ApplicationController
  def new
  end

  def front

  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path
    else
      redirect_to :back
    end
  end
end
