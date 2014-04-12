class AuthorizationController < ApplicationController
  before_action :require_signed_in
  before_action :require_admin

  private
    def require_admin
      unless current_user && current_user.admin?
        flash[:notice] = "You must be logged-in as an admin to do this."
        redirect_to root_path
      end
    end
end
