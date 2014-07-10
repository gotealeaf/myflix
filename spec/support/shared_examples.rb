shared_examples "require_login" do
  it "redirects to the login  page" do
    clear_current_user
    action
    expect(response).to redirect_to login_path
  end
end