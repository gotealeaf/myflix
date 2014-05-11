shared_examples "require_sign_in" do
  it "redirects to the sign in page" do
    clear_current_user
    action
    expect(response).to redirect_to sign_in_path
  end
end

shared_examples "register_authenticated_user" do
  before do
    set_current_user
    action
  end

  it "sets warning if authenticated" do
    expect(flash[:warning]).to eq "You are already logged in."
  end

  it "redirects to home path if authenticated" do
    expect(response).to redirect_to home_path
  end
end

shared_examples "tokenable" do
  it "generates a token on creation" do
    expect(object.token).to_not be_blank 
  end

  it "can generate a new token" do
    old_token = object.token
    object.generate_token
    object.save
    expect(old_token).to_not eq object.reload.token
  end
end