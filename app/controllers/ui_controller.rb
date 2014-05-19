class UiController < ApplicationController
  before_filter do
    redirect_to :root if Rails.env.production?
  end

  layout "application"

  def home
  	@comedies = Video.comedy
  	@dramas   = Video.dramas
  	@action   = Video.action
  end
  def video
  	@video = Video.first
  end
end
