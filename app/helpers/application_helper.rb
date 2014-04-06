module ApplicationHelper

  def rating_selector_options
    ([5,4,3,2,1].map{|n| [pluralize(n, " Star"), n]})
  end

  def rating_default_value(rating)
    rating.nil? ? nil : rating.to_i
  end
end
