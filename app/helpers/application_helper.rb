module ApplicationHelper
  def video_rating_options(selected=nil)
    options_for_select([5,4,2,3,1].map {|number| [pluralize(number, "Star")]}, selected)
  end

  def set_selected(item)
    pluralize(item.rating.to_i, 'Star')
  end
end
