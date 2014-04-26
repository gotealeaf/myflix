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
    user = User.find(params[:user_id])
    Relationship.create(user: user, follower: current_user)  if current_user.can_follow? user
    redirect_to people_path
  end
end