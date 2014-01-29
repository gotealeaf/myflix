class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @relationships = current_user.following_relationships || []
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
    # unless current_user.follows?(leader) || current_user == leader
       if current_user.can_follow?(leader)
      Relationship.create(leader_id: params[:user_id], follower: current_user)
    end
    redirect_to people_path
    
  end

  def can_follow?(leader)
    # unless leader == current_user || current_user.folows?(leader)
      unless current_user.follows?(leader) || current_user == leader
        return true
    else
      return false
    end  
  end


end