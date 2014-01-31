class RelationshipsController < ApplicationController
  def index
    @relationships = current_user.following_relationships
  end
end
