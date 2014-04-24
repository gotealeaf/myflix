class RelationshipsController < ApplicationController
  before_filter :require_user

  def index
    @followed_people = current_user.followed_people
  end
end