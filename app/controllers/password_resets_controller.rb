class PasswordResetsController < ApplicationController
  def show
    user = User.where(token: params[:id].first)
    redirect_to expired_token_path unless user
  end
end
