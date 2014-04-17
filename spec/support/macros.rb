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

def visit_and_add_to_queue(video)
  visit home_path
  find(:xpath, ".//a[@href='/videos/#{video.id}']" ).click
  click_link '+ My Queue'
end
