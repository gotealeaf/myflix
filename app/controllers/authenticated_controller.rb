 class AuthenticatedController < ApplicationController 
  before_action :require_user
end