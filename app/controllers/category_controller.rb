class CategoryController < ApplicationController
  layout "application"

  def show
    @category = Category.find_by(params[:id])
  end

end