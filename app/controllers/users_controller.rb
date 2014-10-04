class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(userparams)
		if @user.save
			flash[:notice] = "You have successfully registered"
			redirect_to signin_path
		else
			render 'new'
		end
	end

	private

	def userparams
		params.require(:user).permit!
	end
end