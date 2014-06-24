class SessionsController < ApplicationController

  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:username] = @user.username
      flash[:success] = "Welcome #{@user.username}"
      redirect_to videos_path
    else
      flash.now[:danger] = "Incorrect email or password. Please try again."
      render :new
    end
  end

  def destroy
    session[:username] = nil
    redirect_to :root
  end

end
