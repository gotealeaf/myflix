def set_fabricated_user
  session[:user_id] = Fabricate(:user).id
end

def set_current_user
  session[:user_id] = current_user.id
end

def create_user_valid_credentials
  alice = Fabricate(:user)
  post :create, email: alice.email, password: alice.password
end

def fabricate_user_valid_credentials
  post :create, user: Fabricate.attributes_for(:user)
end

def create_user_invalid_credentials
  session[:user_id] = nil
  alice = Fabricate(:user)
  post :create, email: alice.email, password: alice.password + 'asdfasdf'
end

def create_user_invalid_input
  post :create, user: { password: 'joelevinger', full_name: 'Joe Levinger' }
end

def create_review_valid_input
  post :create, review: Fabricate.attributes_for(:review), video_id: video.id
end

def destroy_session
  session[:user_id] = Fabricate(:user).id
  get :destroy
end