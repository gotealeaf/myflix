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
