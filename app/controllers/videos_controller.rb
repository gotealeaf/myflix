class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  def index
    @videos = Video.all
  end

  def show

  end

  def new

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

end
