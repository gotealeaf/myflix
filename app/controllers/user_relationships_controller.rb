class UserRelationshipsController < ApplicationController
  before_action :require_user

  def index
    @followees = user_followees(current_user)
    render 'user_relationships/my_people'
  end

  def user_followees(user)
    UserRelationship.where(follower: user).map(&:user)
  end
end