class AdminController < ApplicationController
  before_filter :ensure_admin

  def ensure_admin
    redirect_to videos_path unless current_user.admin
  end
end