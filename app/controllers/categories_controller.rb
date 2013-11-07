class CategoriesController < ApplicationController

  def index
    @videos = Video.all
    @category = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

end

