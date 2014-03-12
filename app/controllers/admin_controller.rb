class AdminController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def require_admin
    unless current_user.admin?
      flash[:error] = "You are not authorized to do that."
      redirect_to root_path
    end
  end
end