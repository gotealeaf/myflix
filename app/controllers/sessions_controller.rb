class SessionsController < ApplicationController

  def new
    redirect_to root_path if current_user
  end

  def create

    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      @current_user
      flash[:success] = "You've signed in."
      redirect_to root_path
    else
      flash[:danger] = "wrong email address or password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You've sign out."
    redirect_to root_path
  end

end
