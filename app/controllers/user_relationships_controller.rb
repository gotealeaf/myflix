class UserRelationshipsController < ApplicationController
  before_action :require_user

  def index
    @user_relationships = current_user.following_relationships
    render 'user_relationships/people'
  end

  def destroy
    user_relationship = UserRelationship.find(params[:id])
    user_relationship.destroy if user_relationship.follower == current_user
    redirect_to people_path
  end
end