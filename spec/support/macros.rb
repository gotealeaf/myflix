
def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit sign_in_path
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
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