module ApplicationHelper
  def convert_flash(treatment)
    return "danger" if treatment == :error
    return "success" if treatment == :notice
    return treatment
  end

  def rating(review)
    return "not rated" if review.rating == nil
    "#{review.rating} / 5"
  end
end
