class AdminsController < ApplicationController
  before_filter :ensure_admin

  def ensure_admin
  	redirect_to root_path unless current_user.admin?
  end
end