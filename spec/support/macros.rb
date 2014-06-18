def set_current_user(user=nil)
  
  session[:user_id] = (user || Fabricate(:user)).id   
end

def sign_in(a_user = nil)
  user = a_user || Fabricate(:user)
  visit sign_in_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button "Sign in"
end

def current_user
  User.find(session[:user_id])
end

def remove_current_user
  session[:user_id] = nil
end

def find_and_click_video_on_home_page(video)
  find("a [href= '/videos/#{video.id}']").click
end