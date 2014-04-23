class PagesController < ApplicationController
  before_action :require_user, except: [:root]
  def root
    if logged_in?
      redirect_to home_path
    end
  end
end
