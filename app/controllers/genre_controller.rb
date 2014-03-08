class GenreController < ApplicationController

  def index
  	@category = Category.find_by(name: 'Action Video')
  	@videos =  Video.where(category_id: @category)
  	# binding.pry
  end
end
