def sign_in(feature_user=nil)
  user = feature_user || Fabricate(:user)
  visit sign_in_path
  fill_in 'Email Address', with: user.email
  fill_in 'Password', with: user.password
  click_button "Sign in"
end

def clear_session
  session[:user_id] = nil
end

def current_user
  @current_user = @current_user || User.find(session[:user_id])
end



 