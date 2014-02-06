class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @relationships = current_user.relationships
  end

  def create
    if params[:leader_id] && params[:leader_id].to_i != current_user.id
      leading_user = User.where(id: params[:leader_id]).first
    end

    relationship = current_user.relationships.new(leader: leading_user)
    if relationship.save
      flash[:success] = "You are now following #{leading_user.full_name}"
    else
      flash[:danger] = 'Something went wrong. Please try again.'
    end
    redirect_to :back
  end

  def destroy
    relationship = current_user.relationships.where(id: params[:id]).first


    if relationship.nil? || !relationship.destroy
      flash[:danger] = 'Something went wrong. Please try again.'
    else
      flash[:success] = "You are no longer following #{relationship.leader.full_name}"
    end
    redirect_to :back
  end
end
