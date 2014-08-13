shared_examples "require_login" do
  it "redirects to the login  page" do
    clear_current_user
    action
    expect(response).to redirect_to login_path
  end
end

shared_examples "generate_token" do
  it "generates a token" do
    instance.generate_token
    expect(instance.token).to_not be_nil
  end
end

shared_examples "requires admin" do
  before { current_user.update_column(:admin, false) }

  it "redirects to the home page" do
    action
    expect(response).to redirect_to home_path
  end

  it "sets the error notice" do
    action
    expect(flash[:error]).to_not be_blank 
  end
end