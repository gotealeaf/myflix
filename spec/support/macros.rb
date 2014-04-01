def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def current_user_in_session
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def user_signs_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit sign_in_path
  fill_in "Email", with: "#{user.email}"
  fill_in "Password", with: "#{user.password}"
  click_button "Sign in"
end