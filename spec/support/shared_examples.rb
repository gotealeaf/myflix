shared_examples 'require sign in' do
  it 'redirects to root path' do
    clear_current_user #from macros
    action
    expect(response).to redirect_to root_path
  end
end
