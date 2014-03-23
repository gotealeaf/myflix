class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
    @ratings = []
    @queue_items.each do |item|
      reviews = Review.where(user: current_user, video: item.video)
      if reviews.empty?
        @ratings.push("")
      else
        @ratings.push(reviews[0].rating)
      end
    end
  end

end