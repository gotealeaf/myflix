class GenresController < ApplicationController

  before_action :require_user

  def show
    @genre = Genre.find(params[:id])
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(category_params)
    if @genre.save
      flash[:notice] = "#{@genre.name} has been added to the list of genres!"
      redirect_to :root
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:genre).permit(:name)
  end
end
