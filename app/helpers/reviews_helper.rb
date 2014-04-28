module ReviewsHelper
  def options_for_select_rating(rating=nil)
    options_for_select( [['5 stars', 5], ['4 stars', 4], ['4 stars', 4], ['2 stars', 2], ['1 stars', 1]], rating)
  end
end
