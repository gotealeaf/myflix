class RelationshipsController < ApplicationController
  before_filter :logged_in?

  def index
    @leads = current_user.following_relationships
  end

  def create
    user = User.find_by_id(params[:leader_id])
    Relationship.create(leader: user, follower: current_user) unless user.blank? || current_user.follows?(user) || current_user == user
    redirect_to people_path
  end

  def destroy
    r1 = Relationship.find_by_id(params[:id])
    r1.destroy unless (r1.blank? || r1.follower != current_user )
    redirect_to people_path
  end

end
