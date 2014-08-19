class UiController < ApplicationController
  before_filter do
    redirect_to :root if Rails.env.production?
  end

  before_action :set_up_videos, only: [:genre, :home]

  layout "application"

  def index
  end

  def genre
    @videos = Video.all
  end

  def home
  end

  private

  def set_up_videos
    @videos = Video.all
  end
end
