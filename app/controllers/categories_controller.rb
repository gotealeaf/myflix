class CategoriesController < ApplicationController

  def show
  	@category = Category.find(params[:id])
  	@videos = @category.videos.first(6)
  end

  def index
  	@categories = Category.all
  end

end