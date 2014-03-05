class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You've logged in! Welcome, #{user.full_name}!"
      redirect_to home_path
    else
      flash[:danger] = "Something was wrong with the email or password you "\
                       "entered. Please try again."
      redirect_to login_path
    end
  end

  def destroy
    flash[:success] = "You've logged out, #{current_user.full_name}! Thanks"\
                      " for stopping by!"
    session[:user_id] = nil
    redirect_to root_path
  end
end