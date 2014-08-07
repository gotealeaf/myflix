module ApplicationHelper
  def options_for_video_rating(selected=nil)
    options_for_select((1..5).map {|n| [pluralize(n, "Star"), n]}, selected)
  end

  def user_avatar_src(email)
    src="http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}?s=40"
  end

  def video_collection_header(user)
    "#{user.full_name}'s video collections (#{user.queue_items.count})"
  end

  def reviews_header(user)
    "#{user.full_name}'s Rviews (#{user.reviews.count})"
  end
end
