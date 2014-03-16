class QueItemsController < ApplicationController
  before_action :current_user, :authorize

  def index
    @que_items = QueItem.order(:created_at).to_a
  end

  def create
    @video = Video.find_by(params[:video_id])
    QueItem.create(que_item_params) unless QueItem.where(video_id: @video).first == @video
    redirect_to que_items_path
  end

  private

  def que_item_params
    params.permit(:video_id, :user_id)
  end

end