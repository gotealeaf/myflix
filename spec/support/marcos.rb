
def set_current_user
  current_user = Fabricate(:user)
  session[:user_id] = current_user.id
end

def get_current_user
  @current_user ||= User.find(session[:user_id])
end


def signin(a_user=nil)
  user = a_user || Fabricate(:user)
  visit signin_path
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password

  click_button "Sign In"
end

def signout
  visit signout_path
end

def click_on_video_on_home_page(video)
  find("a[href='/videos/#{video.token}']").click
end
