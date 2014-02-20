class AdminsController < ApplicationController
  before_action :require_user
  before_action :require_admin

  private

  def require_admin
		if !current_user.admin?
			flash[:error] = "You are not authorized to do that."
			redirect_to root_path 
		end
	end
end