class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show]
  before_action :require_user, except: [:new, :create]
 
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params.require(:user).permit(:full_name, :email, :password))
      if @user.save
        session[:user_id] = @user.id
        redirect_to videos_path
      else
        flash[:danger] = "Your account could not be created. Please make sure all details are filled in correctly."
        render :new
      end
  end
    
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update
      flash[:info] = "Your profile was updated."
      redirect_to user_path(@user)
    else
      flash[:warning] = "Your profile could not be updated."
    end
  end
    
  private
  
  def find_user
    @user = User.find(params[:id])
  end

end