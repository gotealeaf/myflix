class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @relationships = current_user.following_relationships
  end

  def create
    leader = User.find(params[:leader_id])
    if current_user.can_follow?(leader)
      Relationship.create(leader_id: leader.id, follower_id: current_user.id)
      AppMailer.mail_to_leader_when_followed(leader, current_user).deliver
    end
    redirect_to people_path
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if relationship.follower == current_user
    redirect_to people_path
  end
end
