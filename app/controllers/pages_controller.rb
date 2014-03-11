class PagesController <  ApplicationController
  def front
    if session[:user_id]
      redirect_to home_path
    end
  end
end
