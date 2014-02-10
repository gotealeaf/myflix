class CategoriesController < ApplicationController
    before_action :set_category, only: [:show]
    before_filter :require_user

  def show
  end

  private

  def set_category
    @category = Category.find(params[:id]) 
  end

end
