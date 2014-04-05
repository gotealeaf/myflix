class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]

  def new
  end

  def create
    user = User.where(name: params[:name]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Login success"
      redirect_to videos_path
    else
      flash[:error] = "Login fail"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You had logged already'
    redirect_to root_path
  end
end
