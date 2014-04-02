class RelationshipsController < ApplicationController
  def create
    user = User.find_by(params[:user_id])
    current_user.follow!(user)
    redirect_to users_path
  end
end