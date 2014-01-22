class UiController < ApplicationController
 protect_from_forgery with: :exception

 before_filter do
   redirect_to :root if Rails.env.production?
 end

 layout "application"

end
