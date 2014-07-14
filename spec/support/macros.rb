def set_current_user(user=nil)
  batman = user.nil? ? Fabricate(:user) : user
  session[:auth_token] = batman.auth_token
end

def current_user
  User.find_by_auth_token(session[:auth_token])
end

def clear_current_user
  session[:auth_token] = nil
end