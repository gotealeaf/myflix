class Admin::VideosController < ApplicationController
	before_action :require_user
	before_action :require_admin

	def new
		@video = Video.new
	end

	private
	def require_admin
		if !current_user.admin?
			flash[:danger] = "You are not authorized to do that."
			redirect_to home_path
		end
	end
end
