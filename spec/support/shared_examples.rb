# queue_videos_controller_spec.rb
shared_examples 'redirect for authenticated user' do
  it 'should redirect to my_queue page' do
    action
    expect(response).to redirect_to my_queue_path
  end
end

shared_examples 'redirect for unauthenticated user' do
  it 'should redirect to sign_in page' do
    action
    expect(response).to redirect_to sign_in_path
  end
end

# sessions_controller_spec.rb
shared_examples 'redirect to home page' do
  it 'should redirect for authenticated users' do
    action
    expect(response).to redirect_to home_path
  end
end

# users_controller_spec.rb
shared_examples 'new User object' do
  it 'should create a new @user object' do
    action
    expect(assigns(:user)).to be_a_new(User)
  end
end

shared_examples 'requires admin' do
  it 'should redirect to home page if user is not admin' do
    set_session_user
    action
    expect(response).to redirect_to home_path
  end
end
