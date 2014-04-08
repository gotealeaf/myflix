def set_current_user(user=nil)
  user = user || Fabricate(:user)
  session[:user_id] = user.id
end

def sign_in(user=nil)
  user = user || Fabricate(:user)
  visit login_path
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_button 'Sign in'
end

def click_on_video_on_home_page(video)
  find("a[href='/videos/#{video.id}']").click
end

def sign_out
  visit logout_path
end
