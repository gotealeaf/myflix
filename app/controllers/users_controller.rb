class UsersController < ApplicationController
  before_filter :logged_in?, except: [:new, :create]

  def new
    @user = User.new(email: params[:recipient_email])
  end

  def create
    @user = User.new(user_params)
    if @user.save
       AppMailer.notify_on_new(@user).deliver
       redirect_to sign_in_path, notice: "You are signed up. Please log in"
     else
       render "new"
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end 


  private

    def user_params
      params.require(:user).permit(:email, :full_name, :password)
    end

end
