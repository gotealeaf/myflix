
def set_current_user
  darren = Fabricate(:user)
  session[:user_id] = darren.id
end

def clear_current_user
  session[:user_id] = nil
end

def current_user
  User.find(session[:user_id])
end

def post_user_to_session
  darren = Fabricate(:user)
  post :create, email: darren.email, password: darren.password
end