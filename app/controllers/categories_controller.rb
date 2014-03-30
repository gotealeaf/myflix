class CategoriesController < ApplicationController

  def index
    @videos = Video.all
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
