class RelationshipsController < ApplicationController
  before_action :require_user, only: [:create, :destroy]
  before_action :require_same_user, only: :show

  def create
    new_leader = User.find(params[:user_id])
    @new_relationship = Relationship.new(user_id: new_leader.id, follower_id: current_user.id)
    if @new_relationship.save
      flash[:success] = "You have followed #{new_leader.full_name}"
      redirect_to relationship_path(current_user.id)
    else
      @user = new_leader
      render 'users/show'
    end
  end

  def show
    @user = current_user
  end

  def destroy
    relationship = Relationship.where(user_id: params[:leader_id], follower_id: params[:id]).first
    relationship.destroy if relationship
    @user = current_user
    redirect_to relationship_path
  end

  private 

  def require_same_user
    if current_user != User.find(params[:id])
      flash[:error] = "You're not allowed to do that."
      redirect_to login_path
    end
  end
end