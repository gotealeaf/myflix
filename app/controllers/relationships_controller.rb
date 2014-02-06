class RelationshipsController < ApplicationController
  before_filter :require_user

  def index
    @leaders = current_user.leaders
  end

  def create
    user = User.find(params[:user_id])
    Relationship.create(follower_id: current_user.id, leader_id: params[:user_id]) if current_user.allow_to_follow?(user)
    redirect_to people_path
  end

  def destroy
    relationship = Relationship.where(follower_id: current_user.id, leader_id: params[:id]).first
    relationship.destroy if relationship
    redirect_to people_path
  end

end