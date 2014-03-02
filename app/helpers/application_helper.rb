module ApplicationHelper
  def convert_flash(treatment)
    return "danger" if treatment == :error
    return "success" if treatment == :notice
    return treatment
  end

  def options_for_video_reviews(selected=nil)
    options_for_select((1..5).map { |num| [pluralize(num, "Star"), num] }, selected)
  end
end
