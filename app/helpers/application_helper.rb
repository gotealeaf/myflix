module ApplicationHelper

  def rating_selector_options
    ([5,4,3,2,1].map{|n| [pluralize(n, " Star"), n]}).unshift(["Rate Video", ""])
  end

  def rating_default_value(user_rating)
    if user_rating  #1, 2, 3, 4, or 5
      rating_selector_options[(user_rating-1)]
    else  #user_rating == nil
      ""
    end
  end
end
