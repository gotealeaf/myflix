module ApplicationHelper

  def review_options(selected=nil)
    options_for_select([5,4,3,2,1].map { |x| [pluralize(x, "Star"), x] }, selected)
  end
end
