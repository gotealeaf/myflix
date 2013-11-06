class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @videos = Video.all
  end
end