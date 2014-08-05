def set_current_user
  session[:user_id] = Fabricate(:user).id
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def sign_in(user)
  visit login_path
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_out
  visit logout_path
end