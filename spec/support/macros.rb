def logout_user
  session[:user_id] = nil if session[:user_id]
end

def sign_in_user(user = current_user)
  session[:user_id] = user.id
end

def current_user
  @current_user ||= Fabricate(:user)
end

def feature_sign_in_user(user=nil)
  joe = user || Fabricate(:user)
  visit '/signin'
  fill_in "Email Address", with: joe.email
  fill_in "Password",      with: joe.password
  click_button "Sign in"
end

def feature_user_adds_video_to_queue
  visit root_path
  find(:xpath, "//a[@href='/videos/1']").click
  click_link "+ My Queue"
end

#Note: Depends on videos already having been created
def feature_add_videos_to_queue(number)
  (1..number).each do |n|
    visit root_path
    find(:xpath, "//a[@href='/videos/#{n}']").click
    click_link "+ My Queue"
  end
end


