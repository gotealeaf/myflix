class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @relationships = current_user.following_relationships 
  end

  def destroy
    relationship = Relationship.find(params[:id])
    # relationship.destroy if relationship.follower == current_user
    relationship.destroy if relationship.follower == current_user
    flash[:notice] = "You are no longer following them"
    redirect_to people_path
  end

  def create
    leader = User.find(params[:leader_id])
    relationship = Relationship.new(leader_id: params[:leader_id], follower: current_user)
    relationship.save if current_user.can_follow?(leader)
    redirect_to people_path
  end
end