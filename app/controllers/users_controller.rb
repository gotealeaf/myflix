class UsersController < ApplicationController
  before_action :require_signed_out,  only: []
  before_action :require_owner,       only: []
  before_action :require_signed_in,   only: [:show]
  before_action :set_user,            only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      MyflixMailer.welcome_email(@user).deliver
      flash[:notice] = "Welcome to myFlix!"
      signin_user(@user)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_owner
      User.find(params[:id]) == current_user if signed_in?
    end
end
