class CategoriesController < AuthenticatedController
  def show
    @category = Category.find(params[:id])
  end
end