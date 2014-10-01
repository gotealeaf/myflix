class AdminsController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def require_admin
    unless current_user.admin? then
      flash[:error] = "You do not have access to this page"
      redirect_to home_path
    end
  end 

end