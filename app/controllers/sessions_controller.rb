class SessionsController < ApplicationController
  def login
    user = User.find_by email: params[:email]
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      flash[:success] = "You are signed in, enjoy"
      redirect_to home_path
    else
      flash[:warning] = "Invalid email or password"
      redirect_to sign_in_path  #use render :new here would work, strange
    end
  end

end