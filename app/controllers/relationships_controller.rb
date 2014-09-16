class RelationshipsController < ApplicationController
  before_filter :logged_in?

  def index
    @leads = current_user.leads
  end

end
