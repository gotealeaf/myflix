class CategoriesController < ApplicationController
  layout "application"

  def show
    @category = Category.find_by(id: params[:id])
  end

end