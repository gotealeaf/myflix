def sign_in(feature_user=nil)
  user = feature_user || Fabricate(:user)
  visit sign_in_path
  fill_in 'Email Address', with: user.email
  fill_in 'Password', with: user.password
  click_button "Sign in"
end

def sign_out
  visit sign_out_path
end


def set_current_user
  user = Fabricate(:user)
  session[:user_id] = user.id
end


def let_current_user 
  let!(:user) {Fabricate(:user)}
  before  {session[:user_id] = user.id}
end


def clear_session
  session[:user_id] = nil
end

def current_user
  @current_user = @current_user || User.find(session[:user_id])
end

def click_on_video_on_home_page(video)
  visit home_path
  find("a[href='#{video_path(video)}']").click
end

 