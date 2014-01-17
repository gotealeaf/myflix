module ApplicationHelper
  def convert_flash(alert)
    return "danger" if alert == :error
    return "success" if alert == :notice
    return alert
  end
end
