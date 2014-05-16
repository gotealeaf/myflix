class RelationshipsController < ApplicationController
  before_filter :require_user
  
  def index
    @relationships = current_user.following_relationships #will list down everyone that the current user is following
  end
  
  def create
    leader = User.find(params[:leader_id])
    @relationship = Relationship.create(leader_id: params[:leader_id], follower: current_user) if current_user.can_follow?(leader)
    flash[:success] = "You are now following #{leader.full_name}."
    redirect_to people_path
  end
  
  def destroy
    relationship = Relationship.find(params[:id])
    relationship.delete if relationship.follower == current_user
    flash[:danger] = "Relationship deleted."
    redirect_to people_path
  end
  
end