class RelationshipsController < ApplicationController
  before_filter :logged_in?

  def index
    @leads = current_user.following_relationships
  end

  def destroy
    r1 = Relationship.find_by_id(params[:id])
    r1.destroy unless (r1.blank? || r1.follower != current_user )
    redirect_to people_path
  end

end
