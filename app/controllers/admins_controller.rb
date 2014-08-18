class AdminsController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def require_admin
    unless current_user.admin
      flash[:error] = "You don't have access to that."
      redirect_to home_path
    end
  end
end