class UsersController < ApplicationController
  before_action :require_user, only: :update_queue

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Account created successfully, you have been logged in.'
      redirect_to home_path
    else
      render :new
    end
  end

  def update_queue
    current_user.transaction do
      params[:user][:queue_item].each do |id, parameters|
        queue_item = QueueItem.find(id)
        if parameters[:position] =~ /\A\d+\z/ && queue_item.user == current_user
          queue_item.position = parameters[:position]
          queue_item.save
        else
          flash[:danger] = 'There was a problem updating your queue. Please try again.'
          raise ActiveRecord::Rollback
        end
      end
      current_user.sort_queue_items_by_position
    end

    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password)
  end
end
