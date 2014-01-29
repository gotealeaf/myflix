class VideosController < ApplicationController
  before_action :require_user

  def index
    @categories = Category.all
  end

  def show
    @review = Review.new
    @video = Video.find(params[:id])
  end

  def search
    @videos = Video.search_by_title(params[:search_string])
  end

  def queue
    chosen_video = Video.find(params[:id])
    queue_item = current_user.queue_items.new(video: chosen_video, position: current_user.next_available_position)

    if queue_item.save
      flash[:success] = "#{chosen_video.title} was successfully added to your queue."
    else
      flash[:danger] = "There was a problem adding #{chosen_video.title} to your queue. Please try again."
    end

    redirect_to :back
  end

  def dequeue
    video = Video.find(params[:id])
    QueueItem.delete(QueueItem.where(video: video, user: current_user))
    flash[:success] = "#{video.title} was successfully removed from your queue."
    redirect_to :back
  end
end
