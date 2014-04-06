class RelationshipsController < ApplicationController
before_action :require_signed_in

def create
  @user = User.find(params[:user_id])
  @relationship = current_user.following_relationships.create(leader: @user)
  if @relationship.valid?
    flash[:notice] = "You're now following #{@user.name}."
  else
    flash[:error] = "You're already following this person."
  end
  redirect_to people_path
end

def index
  @leaders = current_user.leaders
end

def destroy
  @leader = User.find_by(id: params[:leader_id])
  @relationship = current_user.following_relationships.find_by(leader_id: params[:leader_id])
  if (!@relationship.blank? && @relationship.destroy)
    flash[:notice] = "#{@leader.name} has been removed from your followed people."
  else
    flash[:error] = "#User could not be removed."
  end
  redirect_to people_path
end

end
