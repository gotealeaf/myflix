class VideosController < AuthenticatedController
  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @review = Review.new
    @reviews = @video.reviews
  end

  def search
    @search_results = Video.search_by_title(params[:search])
  end
end