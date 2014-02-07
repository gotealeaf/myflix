shared_examples 'an unauthenticated user' do
  it 'redirects to the sign in page' do
    clear_current_user
    action
    expect(response).to redirect_to sign_in_path
  end

  it 'sets warning message' do
    clear_current_user
    action
    expect(flash[:info]).not_to be_blank
  end
end
