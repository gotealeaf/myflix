class SessionsController < ApplicationController

  def new
    redirect_to :home if logged_in?
  end
  
  def create
    user = User.find_by(email: params[:email])
    
    if user &&  user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :home
    else
      flash.now[:error] = "There is something wrong with your email or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, notice: "You logged out, see you later!"
  end

end