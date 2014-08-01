class RelationshipsController < ApplicationController
  before_action :signed_in_user


  def create
    user = User.find(params[:id])
    @relationship = current_user.relationships.new(followed: user)

    if @relationship.save
      flash[:success] = "You have followed #{user.full_name}"
    else
      flash[:warning] = "Unable to follow #{user.full_name}"
    end
  
    redirect_to following_people_path
  end

  def destroy
    user = User.find(params[:id])
    @relationship = current_user.relationships.find_by_followed_id(user.id)


    @relationship.destroy
    flash[:success] = "You have unfollow #{user.full_name}"

    redirect_to following_people_path
  end
end
