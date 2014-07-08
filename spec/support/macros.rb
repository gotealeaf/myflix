def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit sign_in_path
  find(".sign_in").fill_in "email", with: user.email
  find(".sign_in").fill_in "password", with: user.password
  find(".sign_in").click_button "Sign In"
end

def click_video_on_home_page(video)
  find("a[href='/videos/#{video.id}']").click
end

def sign_out
  visit sign_out_path
end