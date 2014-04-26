def set_current_user
  user = Fabricate(:user)
  session[:user_id] = user
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit sign_in_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
  user
end

def click_video_link_on_home_page(video)
  find(:xpath, "//a[@href='/videos/#{video.id}']" ).click
end