def logout_user
  session[:user_id] = nil if session[:user_id]
end

def sign_in_user(user = current_user)
  session[:user_id] = user.id
end

def current_user
  @current_user ||= Fabricate(:user)
end

############################## FEATURE SPEC METHODS ############################

def click_video_image_link(video)
  find(:xpath, "//a[@href='/videos/#{video.id}']").click
end



def signin_user(user=nil)
  joe = user || Fabricate(:user)
  visit '/signin'
  fill_in "Email Address", with: joe.email
  fill_in "Password",      with: joe.password
  click_button "Sign in"
end

def verify_number_of_items_in_queue(number)
  body.should have_field("queue_items[][position]", count: "#{number}")
end



