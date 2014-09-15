class RelationshipsController < ApplicationController
  before_filter :require_user
  
  def index
    @relationships = current_user.following_relationships
  end

  def create
    @relationship = current_user.relationship.new(:user_id => params[:relationship_id])
    if @relationship.save

    else

    end
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if relationship.follower == current_user
    redirect_to people_path 
  end
end