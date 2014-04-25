def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def sign_in_user(a_user=nil)
  user = a_user || Fabricate(:user)
  visit login_path
  fill_in 'Email Address', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end

def sign_out_user(user)
  visit home_path
  click_link "Sign Out"
end

def create_queue_items
  video1 = Fabricate(:video)
  video2 = Fabricate(:video)
  video3 = Fabricate(:video)
  queue_item1 = Fabricate(:queue_item, user_id: current_user.id, video_id: video1.id, position: 1)
  queue_item2 = Fabricate(:queue_item, user_id: current_user.id, video_id: video2.id, position: 2)
  queue_item3 = Fabricate(:queue_item, user_id: current_user.id, video_id: video3.id, position: 3)
end

def fabricate_video_and_post_to_create
  video = Fabricate(:video)
  post :create, video_id: video.id
end

def fabricate_queue_item_with_category
  user = Fabricate(:user)
  category = Fabricate(:category)
  video = Fabricate(:video, category_id: category.id)
  queue_item = Fabricate(:queue_item, video_id: video.id, user_id: user.id)
end

def queue_item(id)
  QueueItem.find(id)
end
