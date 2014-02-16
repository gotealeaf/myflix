class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @videos = Video.all.where(category: @category)
  end
end