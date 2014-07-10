module ApplicationHelper

  def review_options
    [5,4,3,2,1].map { |x| [pluralize(x, "Star"), x] }
  end
end
