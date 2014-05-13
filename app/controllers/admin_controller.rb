class AdminController < ApplicationController
  helper_method :ensure_admin
  def ensure_admin
    redirect_to videos_path, notice: "Access denied." unless current_user.admin
  end
end