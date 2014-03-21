class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:info] = "Access granted!"
      redirect_to home_path
    else
      flash[:danger] = "Your email or password do not match."
      redirect_to sign_in_path
    end
  end
end