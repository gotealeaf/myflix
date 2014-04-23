class CategoriesController < ApplicationController
  before_action :require_user

  def show
    @category = Category.find_by id: params[:id]
  end
end
