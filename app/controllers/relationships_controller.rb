class RelationshipsController < ApplicationController

  def index
   @relationship = current_user.following_relationships
  end
end