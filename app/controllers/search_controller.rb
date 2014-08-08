class SearchController < ApplicationController

  def index
    keyword = params[:search].strip

    if video = find_jump_target keyword
      redirect_to jump
    else
      @results = Video.search(keyword)
    end
  end

  private
    def find_jump_target(keyword)
      Video.find_by(title: keyword.titleize) ||
      User.find_by(full_name: keyword)
    end

end
