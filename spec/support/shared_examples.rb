shared_examples "require_logged_in_user" do
  it 'redirects to login path' do
    clear_user_from_session
    action
    expect(response).to redirect_to login_path
  end
  it 'displays and error message message' do
    clear_user_from_session
    action
    expect(flash[:danger]).to be_present
  end
end

shared_examples "redirect_to my_queue_path" do
  it 'redirects the user to the login path' do
    action
    expect(response).to redirect_to my_queue_path
  end
end
