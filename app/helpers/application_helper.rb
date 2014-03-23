module ApplicationHelper
  def alert_class(alert_type)
    bootstrap_name = { error: "danger" }[alert_type.to_sym] || "info"
    "alert alert-#{bootstrap_name}"
  end
end
