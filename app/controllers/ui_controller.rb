class UiController < ApplicationController
  before_action do
    redirect_to :root if Rails.env.production?
  end

  layout "application"

  def index
  end
end
