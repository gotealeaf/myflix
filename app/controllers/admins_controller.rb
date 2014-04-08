class AdminsController < ApplicationController
  before_action :require_admin
end
