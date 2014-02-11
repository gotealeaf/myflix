class PagesController < ApplicationController
  before_action :require_user, except: [:root]

end
