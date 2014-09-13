def set_current_user(existing_user=nil)
  u = existing_user || Fabricate(:user)
  session[:user_id] = u.id
end

def clear_current_user
  session[:user_id] = nil
end

def current_user
  User.find(session[:user_id])
end

def sign_in(existing_user=nil)
    user = existing_user || Fabricate(:user)
    visit sign_in_path
    fill_in "Email Address", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
end

