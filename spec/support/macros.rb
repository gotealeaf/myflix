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

def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit sign_in_path
  fill_in('Email', with: user.email)
  fill_in('Password', with: user.password)
  click_on('Sign In')
end