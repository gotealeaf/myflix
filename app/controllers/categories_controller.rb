class CategoriesController < ApplicationController

  def show
  	@category = Category.find(params[:id])
  	@videos = @category.videos.all
  end

end