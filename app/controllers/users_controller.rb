class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
       redirect_to "/" 
     else
       render "new"
    end
  end

  def new
    @user = User.new
  end

  def sign_in
    @user = User.new
  end

  def start_session
    user = User.find_by_email_and_password(params[:user][:email], params[:user][:password])
    if user.blank?
      @user = User.new
      @user = User.new(user_params)
      render "sign_in"
    else
      redirect_to "/home" 
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :full_name, :password)
    end

end
