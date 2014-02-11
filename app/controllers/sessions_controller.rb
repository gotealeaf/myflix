class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.where(email: params[:user][:email]).first
    user = @user
    binding.pry
    if user && user.authenticate(params[:user][:password])
      binding.pry
      session[:user_id] = user.id
      redirect_to home_path
    else
      binding.pry
      flash[:eror]
      redirect_to :back
    end
    binding.pry
  end
end
