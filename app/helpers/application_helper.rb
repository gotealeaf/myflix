module ApplicationHelper

  def ratings_avg(video)
    ratings_array = []
    
    if !video.reviews.empty?
      ratings_array = video.reviews.map {|r| r.rating}
      return ratings_array.sum.to_f/ratings_array.size.to_f
    else
      
     return  "No Reviews"
    end
  end
  
  def options_for_video_reviews(selected=nil)
    options_for_select((1..5).map {|num| [pluralize(num, "Star"),num]}, selected)
  end

end
