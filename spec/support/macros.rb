def set_current_user
  u = Fabricate(:user)
  session[:user_id] = u.id
end

def clear_current_user
  session[:user_id] = nil
end

def current_user
  User.find(session[:user_id])
end

