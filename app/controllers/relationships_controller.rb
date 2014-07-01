class RelationshipsController < ApplicationController
  before_filter :require_user

  def index
    @relationships = current_user.following_relationships
  end

  def create
    leader = User.find(params[:leader_id])
    follower = current_user
    create_relationship(leader, follower) unless follower.following?(leader, follower)
    redirect_to people_path
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if relationship.follower == current_user
    redirect_to people_path
  end

  private

  def create_relationship(leader, follower)
    Relationship.create(leader_id: leader.id, follower_id: follower.id)
  end

end
