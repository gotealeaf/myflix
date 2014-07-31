def set_current_user
  current_user = Fabricate(:user)
  session[:user_id] = current_user.id
end

def current_user
  @current_user ||= User.find(session[:user_id])
end
