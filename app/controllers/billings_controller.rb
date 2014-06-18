class BillingsController < ApplicationController
  before_filter :require_user, only: [:show]
  before_filter :find_user
  
  def show
    @billing = Payment.find(params[:payment])
  end
  
  private
  
  def find_user
    @user = User.find(params[:id])
  end
  
end