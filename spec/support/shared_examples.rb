shared_examples 'require sign in' do
  it 'redirects to root path' do
    clear_current_user #from macros
    action
    expect(response).to redirect_to root_path
  end
end

shared_examples 'generate token' do
  it 'generates a random token when tokenable is called' do
    expect(object.token).to be_present
  end
end

shared_examples 'require admin' do
  it 'redirects to home path if user is not authorised to access the page' do
    set_current_user
    action
    expect(response).to redirect_to home_path
    end
end

shared_examples 'require same user' do
  it "redirects to login path if a different user tries to edit another user's profile" do
    set_current_user
    action
    expect(response).to redirect_to login_path
  end
end
