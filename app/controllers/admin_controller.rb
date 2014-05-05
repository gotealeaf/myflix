class AdminController < AuthenticatedController
  before_action :require_admin

  def require_admin
    unless current_user.admin?
      flash[:danger] = "You do not have permission to do that."
      redirect_to home_path 
    end
  end
end