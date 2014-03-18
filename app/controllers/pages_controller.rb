class PagesController < ApplicationController
  def front
    redirect_to :home if logged_in?
  end
end  