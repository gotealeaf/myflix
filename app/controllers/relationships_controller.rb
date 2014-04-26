class RelationshipsController < ApplicationController
  before_filter :require_user

  def index
    @relationships = current_user.reverse_relationships
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if current_user == relationship.follower
    redirect_to people_path current_user
  end

  def create
    
  end
end