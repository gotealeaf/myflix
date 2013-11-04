class CategoriesController < ApplicationController

  def show
  	@category = Category.find(params[:id])
  	@videos = @category.videos.all
  end

  def index
  	@categories = Category.all
  end

end