class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @videos = @category.videos
  end
end
