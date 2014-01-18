module ApplicationHelper
  def convert_flash(treatment)
    return "danger" if treatment == :error
    return "success" if treatment == :notice
    return treatment
  end
end
