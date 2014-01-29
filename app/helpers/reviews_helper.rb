module ReviewsHelper

def display_rating_for(review)
    if review.has_rating?
      "#{review.rating} /5"
    else
      "none"
    end
  end

  def test_helper(review)
    "Victory!"
    
  end
 
end
