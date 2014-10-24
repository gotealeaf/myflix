class VideosController < ApplicationController
  
  layout "application"
  before_action :require_user
  
  def index
    @videos = Video.all
    @categories = Category.all.sort_by {|cat| cat.name}
  end
  
  def show
    @video = Video.find(params[:id])
    @review = Review.new
    @reviews = @video.reviews.sort_by {|x| x.created_at}.reverse
    @rating = average_rating(@video)
  end
  
  def search
    @search_term = params[:search_term]
    @videos = Video.search_by_title(params[:search_term])
    render 'search'
  end
  
  private
  
  def average_rating(video)
    ratings = video.reviews.map(&:rating)
    (ratings.sum / ratings.size.to_f).round(2)
  end
  
end