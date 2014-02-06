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

  def follow_or_unfollow_button(user_to_follow_or_unfollow)
    if current_user.can_follow?(user_to_follow_or_unfollow)
      link_to 'Follow', relationships_path(leader_id: "#{user_to_follow_or_unfollow.id}"), method: :post, class: 'button btn btn-default', style: 'float: right'
    elsif current_user != user_to_follow_or_unfollow
      link_to 'Unfollow', relationship_path(Relationship.find_by_user_and_leader(current_user, user_to_follow_or_unfollow)), method: :delete, class: 'button btn btn-default', style: 'float: right'
    end
  end
end
