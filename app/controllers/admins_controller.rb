class AdminsController < ApplicationController
  before_filter :require_user
  before_filter :ensure_admin
  
  def ensure_admin
    if !current_user.admin?
    flash[:danger] = "You do not have permission to access that area."
    redirect_to home_path 
    end
  end
  
end