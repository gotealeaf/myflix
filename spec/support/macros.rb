def set_current_user
  session[:user_id] = Fabricate(:user).id
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def sign_in(user = nil)
  user ||= Fabricate(:user)
  visit root_path
  click_on 'Sign In'
  fill_in 'Email Address', with: user.email
  fill_in 'Password', with: user.password
  click_on 'Sign in'
end
