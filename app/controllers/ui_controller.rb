class UiController < ApplicationController
  before_filter do
    redirect_to :root if Rails.env.production?
    @current_user = User.first
  end

  layout "application"

  def index
  end
end
