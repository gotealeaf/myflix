class RelationshipsController < ApplicationController
  before_filter :require_user
  
  def index
    @relationships = current_user.following_relationships #will list down everyone that the current user is following
  end
  
  def create
  end
  
  def destroy
    relationship = Relationship.find(params[:id])
    relationship.delete if relationship.follower == current_user
    flash[:danger] = "Relationship deleted."
    redirect_to people_path
    #relationship = Relationship.find(params[:id])
  end
  
end