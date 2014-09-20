class UsersController < ApplicationController
  before_filter :logged_in?, except: [:new, :create, :forgot_password, :confirm_password_reset, :reset_password]


  def new
    @user = User.new
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

  def forgot_password
  end
 
  def confirm_password_reset
    email = params[:email]
    @found_email = User.find_by_email(email).present?
    if @found_email
      AppMailer.send_password_reset(email).deliver
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :full_name, :password)
    end

end
