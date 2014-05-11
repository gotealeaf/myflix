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

def sign_in(a_user=nil, a_password=nil)
  user = a_user || Fabricate(:user)
  password = a_password || user.password

  visit sign_in_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: password
  click_button 'Sign in'

  user
end

def sign_out
  visit sign_out_path
end

def click_video_link_on_home_page(video)
  find(:xpath, "//a[@href='/videos/#{video.id}']" ).click
end

def open_email_and_click_link(email, link)
  open_email email
  current_email.click_link link
end