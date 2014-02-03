module ApplicationHelper
  def my_form_for(record, options = {}, &block)
    form_for(record, options.merge!({builder: MyFormBuilder}), &block)
  end

  def my_queue_rating_select_options(selected_value)
    options = Review.valid_ratings.reverse.inject({}) do |hash,  rating|
      hash[pluralize(rating, 'Star')] = rating
      hash
    end

    options_for_select(options, selected_value)
  end

  def reviews_with_rating_for_video(video)
    video.reviews.select{ |review| review.rating }
  end
end
