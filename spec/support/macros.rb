def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def sign_in(user=nil)
  lalaine = user || Fabricate(:user)
  visit sign_in_path
  fill_in :email, with: lalaine.email
  fill_in :password, with: lalaine.password
  click_button "Sign in"
end

def click_on_video_on_home_page(video)
  find("a[href='/videos/#{video.id}']").click
end