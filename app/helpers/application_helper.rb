module ApplicationHelper
  def convert_flash(treatment)
    return "danger" if treatment == :error
    return "success" if treatment == :notice
    return treatment
  end

  def rating(review)
    return "not rated" if review.rating.nil?
    "#{review.rating} / 5"
  end

  def rating_option
    [0,5,4,3,2,1].map {|number| [number != 0 ? pluralize(number, "Star") : 'not yet rated', number]}
  end
end
