class CategoriesController < ApplicationController
  def show
    @category = Category.first
  end
end